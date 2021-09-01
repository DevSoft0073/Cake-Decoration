//
//  DailyInventoryVC.swift
//  CakeDecoration
//
//  Created by MyMac on 08/08/21.
//
import UIKit
import Foundation

class DailyInventoryVC : BaseVC, UITableViewDelegate, UITableViewDataSource {
    
    
    //------------------------------------------------------
    
    //MARK: IBOutlet(s)
    
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    @IBOutlet weak var txtSelectDate: UITextField!
    
    //------------------------------------------------------
    
    //MARK: Variable Declarations
    
    var updatedData = [String]()
    var items : [ShowItems] = []
    var itemCounts = 0
    
    //------------------------------------------------------
    
    //MARK: Memory Management Method
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //------------------------------------------------------
    
    deinit { //same like dealloc in ObjectiveC
        
    }
    
    //------------------------------------------------------
    
    //MARK: Custome
    
    func configureUI(){
        
        let identifier = String(describing: DailyInventoryCell.self)
        let nibCell = UINib(nibName: identifier, bundle: Bundle.main)
        tblList.register(nibCell, forCellReuseIdentifier: identifier)
        tblList.delegate = self
        tblList.dataSource = self
        tblList.separatorStyle = .none
    }
    
    @objc func doneButtonPressed() {
        if let  datePicker = self.txtSelectDate.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            self.txtSelectDate.text = dateFormatter.string(from: datePicker.date)
        }
        self.txtSelectDate.resignFirstResponder()
    }
    
    func validateData()  {
        
    }
    
    func performAddDailyInventory(completion:((_ flag: Bool) -> Void)?) {
        _ = false
        var finalArray = [[String : Any]]()
        for index in 0..<self.itemCounts{
            let index = IndexPath(row: index, section: 0)
            if let cell = self.tblList.cellForRow(at: index) as? DailyInventoryCell{
                //                cell.
                let newArray: [String : Any] = [
                    Request.Parameter.item_name : cell.lblItemName.text ?? "",
                    Request.Parameter.display_case : cell.displayFld.text ?? "",
                    Request.Parameter.walk_in : cell.walkinFld.text ?? "",
                    Request.Parameter.other_storage : cell.otherStorageFld.text ?? "",
                    Request.Parameter.total : "",
                    Request.Parameter.last_inventory_count : cell.priceFld.text ?? "",
                    Request.Parameter.last_inventory_date : cell.producedFld.text ?? "",
                    Request.Parameter.variance : "",
                ]
                finalArray.append(newArray)
            }
        }
        
        let parameter: [String: Any] = [
            Request.Parameter.employeeId: currentUser?.id ?? String(),
            Request.Parameter.avgVal : "",
            Request.Parameter.inventoryDate : txtSelectDate.text ?? String(),
            Request.Parameter.item_detail : finalArray,
        ]
        
        RequestManager.shared.requestPOST(requestMethod: Request.Method.addDailyInventory, parameter: parameter, showLoader: false, decodingType: ResponseModal<UserModal>.self, successBlock: { (response: ResponseModal<UserModal>) in
            
            LoadingManager.shared.hideLoading()
            
            if response.code == Status.Code.success {
                delay {
                    
                    DisplayAlertManager.shared.displayAlert(target: self, animated: true, message: response.message ?? String()) {
                        self.pop()
                    }
                }
            } else {
                
                delay {
                    DisplayAlertManager.shared.displayAlert(animated: true, message: response.message ?? String(), handlerOK: nil)
                }
            }
            
        }, failureBlock: { (error: ErrorModal) in
            
            LoadingManager.shared.hideLoading()
            
            delay {
                DisplayAlertManager.shared.displayAlert(animated: true, message: error.errorDescription, handlerOK: nil)
            }
        })
    }
    
    func performGetListing(completion:((_ flag: Bool) -> Void)?) {
        
        let parameter: [String: Any] = [
            Request.Parameter.employeeId: currentUser?.id ?? String(),
        ]
        
        RequestManager.shared.requestPOST(requestMethod: Request.Method.getAllItems, parameter: parameter, showLoader: false, decodingType: ResponseModal<[ShowItems]>.self, successBlock: { (response: ResponseModal<[ShowItems]>) in
            
            LoadingManager.shared.hideLoading()
            
            if response.code == Status.Code.success {
                
                self.items.append(contentsOf: response.data ?? [])
                self.itemCounts = self.items.count
                self.tblList.reloadData()
                
            } else {
                
                delay {
                    DisplayAlertManager.shared.displayAlert(animated: true, message: response.message ?? String(), handlerOK: nil)
                }
            }
            
        }, failureBlock: { (error: ErrorModal) in
            
            LoadingManager.shared.hideLoading()
            
            delay {
                DisplayAlertManager.shared.displayAlert(animated: true, message: error.errorDescription, handlerOK: nil)
            }
        })
    }
    
    
    //------------------------------------------------------
    
    //MARK: perform calculation
    func performCalculation(){
        var totalVariance = 0
        for index in 0..<self.itemCounts{
            let index = IndexPath(row: index, section: 0)
            if let cell = self.tblList.cellForRow(at: index) as? DailyInventoryCell{
                let displayCaseVal = Int(cell.displayFld.text ?? "") ?? 0
                let walkInVal = Int(cell.walkinFld.text ?? "") ?? 0
                let otherStorageVal = Int(cell.otherStorageFld.text ?? "") ?? 0
                if (displayCaseVal + walkInVal + otherStorageVal) != 0{
                    cell.totalFld.text = "\(displayCaseVal + walkInVal + otherStorageVal)"
                }
                
                let expectedTotal = Int(cell.totalFld.text ?? "") ?? 0
                let actualTotal = Int(cell.priceFld.text ?? "") ?? 0
                let varianceVal = expectedTotal - actualTotal
                cell.varianceFld.text = "\(varianceVal)"
                //total variance
                totalVariance += Int(cell.varianceFld.text ?? "") ?? 0
                
            }
        }
        
    }
    
    
    //MARK: Actions
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddRow(_ sender: UIButton) {
        self.itemCounts += 1
        DispatchQueue.main.async {
            UIView.transition(with: self.tblList, duration: 0.3, options: .transitionCrossDissolve, animations: {self.tblList.reloadData()}, completion: nil)
        }
    }
    
    @IBAction func doneBtn(_ sender: UIButton) {
        LoadingManager.shared.showLoading()
        
        self.performAddDailyInventory { (flag : Bool) in
        }
    }
    
    
    //------------------------------------------------------
    
    //MARK: TableView Delegate Datasource Method(s)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DailyInventoryCell.self)) as? DailyInventoryCell {
            let data = items[indexPath.row]
            cell.lblItemName.text = data.itemName
            cell.displayFld.delegate = self
            cell.walkinFld.delegate = self
            cell.otherStorageFld.delegate = self
            cell.producedFld.delegate = self
            cell.varianceFld.delegate = self
            cell.priceFld.delegate = self
            cell.priceFld.text = data.lastInventoryCount
            cell.selectionStyle = .none
            cell.producedFld.text = data.lastInventoryDate
            return cell
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        let date = Date().string(format: "yyyy-MM-dd")
        txtSelectDate.text = date
        txtSelectDate.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
        self.performGetListing { (flag : Bool) in
            
        }
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}


extension DailyInventoryVC : UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.performCalculation()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.performCalculation()
        
        return true
        
    }
    
}

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

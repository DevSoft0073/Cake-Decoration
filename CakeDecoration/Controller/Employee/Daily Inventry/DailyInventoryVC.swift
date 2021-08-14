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
    @IBOutlet weak var txtMissedValue: UITextField!
    @IBOutlet weak var txtRetailValue: UITextField!
    
    //------------------------------------------------------
    
    //MARK: Variable Declarations
    
    var updatedData = [String]()
    var items : [GetAllListing] = []
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
    
    func performAddDailyInventory(completion:((_ flag: Bool) -> Void)?) {
        
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
                    Request.Parameter.total_H : cell.totalFld.text ?? "",
                    Request.Parameter.price : cell.priceFld.text ?? "",
                    Request.Parameter.purchased : cell.producedFld.text ?? "",
                    Request.Parameter.sold : cell.soldFld.text ?? "",
                    Request.Parameter.actual_total : cell.actualTotalFld.text ?? "",
                    Request.Parameter.variance : cell.varianceFld.text ?? "",
                ]
                
                finalArray.append(newArray)
            }
        }
        
        print("here is final array",finalArray)
        
        
        let parameter: [String: Any] = [
            Request.Parameter.employeeId: "2",
            Request.Parameter.avgVal : "33",
            Request.Parameter.inventoryDate : "2021-08-09",
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
        
        RequestManager.shared.requestPOSTT(requestMethod: Request.Method.getAllItems, showLoader: false, decodingType: ResponseModal<[GetAllListing]>.self, successBlock: { (response: ResponseModal<[GetAllListing]>) in
            
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
                
                let total = Int(cell.totalFld.text ?? "") ?? 0
                let purchased = Int(cell.producedFld.text ?? "") ?? 0
                let sold = Int(cell.soldFld.text ?? "") ?? 0
                if (total + purchased - sold) != 0 && (total + purchased - sold) > 0 && cell.producedFld.text != "" && cell.soldFld.text != ""{
                    cell.expectTotalFld.text = "\(total + purchased - sold)"

                }
                
                let expectedTotal = Int(cell.expectTotalFld.text ?? "") ?? 0
                let actualTotal = Int(cell.actualTotalFld.text ?? "") ?? 0
                let varianceVal = actualTotal - expectedTotal
                if varianceVal > 0{
                    cell.varianceFld.text = "\(varianceVal)"
                }
                
                //total variance
                totalVariance += Int(cell.varianceFld.text ?? "") ?? 0
                
            }
        }
        if totalVariance > 0{
            var txtRetailVal = Int(self.txtRetailValue.text ?? "") ?? 0
            if txtRetailVal == 0{
                txtRetailVal = 1
            }
            self.txtMissedValue.text = "\(txtRetailVal * totalVariance)"

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
//
    }
    
    @IBAction func doneBtn(_ sender: UIButton) {
        
        LoadingManager.shared.showLoading()
        
        self.performAddDailyInventory { (flag : Bool) in
        }
    }
    //------------------------------------------------------
    
    //MARK: TableView Delegate Datasource Method(s)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemCounts
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DailyInventoryCell.self)) as? DailyInventoryCell {
            let data = items[indexPath.row]
            cell.lblItemName.text = data.name
            cell.displayFld.delegate = self
            cell.walkinFld.delegate = self
            cell.otherStorageFld.delegate = self
            cell.producedFld.delegate = self
            cell.soldFld.delegate = self
            cell.actualTotalFld.delegate = self
            cell.varianceFld.delegate = self
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        txtSelectDate.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
        self.txtRetailValue.delegate = self
        self.txtMissedValue.isUserInteractionEnabled = false
        self.performGetListing { (flag : Bool) in
            
        }
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //------------------------------------------------------
}


extension DailyInventoryVC : UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.performCalculation()
    }
}

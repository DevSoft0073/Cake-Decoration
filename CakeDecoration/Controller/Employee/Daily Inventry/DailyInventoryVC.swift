//
//  DailyInventoryVC.swift
//  CakeDecoration
//
//  Created by MyMac on 08/08/21.
//
import UIKit
import Foundation

class DailyInventoryVC : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    @IBOutlet weak var txtSelectDate: UITextField!
    @IBOutlet weak var txtMissedValue: UITextField!
    @IBOutlet weak var txtRetailValue: UITextField!
    //------------------------------------------------------
    var updatedData = [String]()
    //MARK: IBOutlet(s)
    
    @IBOutlet weak var tblList: UITableView!
    
    //------------------------------------------------------
    
    //MARK: Variable Declarations
    
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
        
        let newArray: [String : Any] = [
            Request.Parameter.item_name : "",
            Request.Parameter.display_case : "",
            Request.Parameter.walk_in : "",
            Request.Parameter.other_storage : "",
            Request.Parameter.total_H : "",
            Request.Parameter.price : "",
            Request.Parameter.purchased : "",
            Request.Parameter.sold : "",
            Request.Parameter.actual_total : "",
            Request.Parameter.variance : "",
        ]
        
        let parameter: [String: Any] = [
            Request.Parameter.employeeId: "2",
            Request.Parameter.avgVal : "33",
            Request.Parameter.inventoryDate : "2021-08-09",
            Request.Parameter.item_detail : newArray,
        ]
        
        RequestManager.shared.requestPOST(requestMethod: Request.Method.addDailyInventory, parameter: parameter, showLoader: false, decodingType: ResponseModal<UserModal>.self, successBlock: { (response: ResponseModal<UserModal>) in
            
            LoadingManager.shared.hideLoading()
            
            if response.code == Status.Code.success {
                delay {
                    DisplayAlertManager.shared.displayAlert(animated: true, message: response.message ?? String(), handlerOK: nil)
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
    
    //------------------------------------------------------
    
    //MARK: Actions
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddRow(_ sender: UIButton) {
        self.performAddDailyInventory { (flag : Bool) in
            
        }
    }
    
    //------------------------------------------------------
    
    //MARK: TableView Delegate Datasource Method(s)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 9
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DailyInventoryCell.self)) as? DailyInventoryCell {
            cell.selectionStyle = .none
//            DispatchQueue.main.async {
//                self.tblHeight.constant = self.tblList.contentSize.height
//            }
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

    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //------------------------------------------------------
}

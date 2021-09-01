//
//  AddedInventoryVC.swift
//  CakeDecoration
//
//  Created by MyMac on 17/08/21.
//
import UIKit
import Foundation

class AddedInventoryVC : BaseVC, UITableViewDelegate , UITableViewDataSource{
    
    
    @IBOutlet weak var tblList: UITableView!
    
    var items: [ShowItems] = []
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
        
        let identifier = String(describing: InventoryCell.self)
        let nibCell = UINib(nibName: identifier, bundle: Bundle.main)
        tblList.register(nibCell, forCellReuseIdentifier: identifier)
        tblList.delegate = self
        tblList.dataSource = self
        tblList.separatorStyle = .none
    }
    
    func performGetListing(completion:((_ flag: Bool) -> Void)?) {
        
        let parameter: [String: Any] = [
            Request.Parameter.employeeId: currentUser?.id ?? String(),
        ]
        self.items.removeAll()
        RequestManager.shared.requestPOST(requestMethod: Request.Method.getAllItems, parameter: parameter, showLoader: false, decodingType: ResponseModal<[ShowItems]>.self, successBlock: { (response: ResponseModal<[ShowItems]>) in
            
            LoadingManager.shared.hideLoading()
            
            if response.code == Status.Code.success {
                
                self.items.append(contentsOf: response.data ?? [])
                self.items = self.items.removingDuplicates()
                self.itemCounts = self.items.count
                self.tblList.reloadData()
                
            } else if response.code == Status.Code.notfound  {
                
                self.items.removeAll()
                self.tblList.reloadData()
                
            }else{
                
                delay {
                }
            }
            
        }, failureBlock: { (error: ErrorModal) in
            
            LoadingManager.shared.hideLoading()
            
            delay {
                DisplayAlertManager.shared.displayAlert(animated: true, message: error.errorDescription, handlerOK: nil)
            }
        })
    }
    
    
    func performAddEditInventory(inventoryName : String , itemID : String , isDelete : String,completion:((_ flag: Bool) -> Void)?) {
        
        let parameter: [String: Any] = [
            Request.Parameter.employeeId: currentUser?.id ?? String(),
            Request.Parameter.itemName: inventoryName,
            Request.Parameter.itemID: itemID,
            Request.Parameter.dlt: isDelete,
        ]
        
        RequestManager.shared.requestPOST(requestMethod: Request.Method.addEditInventory, parameter: parameter, showLoader: false, decodingType: BaseResponseModal.self, successBlock: { (response: BaseResponseModal) in
            
            LoadingManager.shared.hideLoading()
            
            if response.code == Status.Code.success {
                
                delay {
                    DisplayAlertManager.shared.displayAlert(message: response.message ?? String())
                                        
                    self.performGetListing { (flag : Bool) in
                        
                    }
                    
                }
                
                
            } else {
                
                delay {
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
    
    //MARK: Action
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnAddInventory(_ sender: Any) {
        let alert = UIAlertController(title: "Cake Decoration", message: "Add Inventory", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Name"
        }

        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(textField?.text ?? String())")
            if textField!.text!.isEmpty{
                return
            }
            
            LoadingManager.shared.showLoading()
            
            self.performAddEditInventory(inventoryName: textField!.text!, itemID: "", isDelete: "0") { (flag : Bool) in
            }
        }))

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    //------------------------------------------------------
    
    //MARK: TableView Delegate Datasource Method(s)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if items.count == 0 {
            self.tblList.setEmptyMessage("No data found!")
        } else {
            self.tblList.restore()
        }
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: InventoryCell.self)) as? InventoryCell {
            cell.selectionStyle = .none
            let data = items[indexPath.row]
            cell.lblOrder.text = "Item Name: \(data.itemName ?? String())"
            cell.btnEdit.tag = indexPath.row
            cell.btnEdit.addTarget(self, action: #selector(editInventory(sender:)), for: .touchUpInside)
            cell.btnDlt.tag = indexPath.row
            cell.btnDlt.addTarget(self, action: #selector(dltItems(sender:)), for: .touchUpInside)

            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    @objc func dltItems(sender : UIButton) {
        
        let data = items[sender.tag]
        
        LoadingManager.shared.showLoading()
        
        self.performAddEditInventory(inventoryName: "", itemID: data.itemID ?? String(), isDelete: "1") { (flag : Bool) in
        }
    }
    
    @objc func editInventory(sender : UIButton) {
        
        let data = items[sender.tag]
        
        let alert = UIAlertController(title: "Cake Decoration", message: "Edit Inventory", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = data.itemName
        }

        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(textField?.text ?? String())")
            if textField!.text!.isEmpty{
                return
            }
            
            LoadingManager.shared.showLoading()
            
            self.performAddEditInventory(inventoryName: textField!.text!, itemID: data.itemID ?? String(), isDelete: "0") { (flag : Bool) in
            }
        }))

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblList.separatorColor = .clear
        tblList.separatorStyle = .none
        
        configureUI()
        
        LoadingManager.shared.showLoading()
        
        self.performGetListing { (flag : Bool) in
            
        }
        
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //------------------------------------------------------
}

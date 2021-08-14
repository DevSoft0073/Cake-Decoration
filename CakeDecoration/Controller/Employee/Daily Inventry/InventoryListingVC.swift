//
//  InventoryListingVC.swift
//  CakeDecoration
//
//  Created by MyMac on 14/08/21.
//
import UIKit
import Foundation

class InventoryListingVC : BaseVC, UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var tblList: UITableView!
    
    var items: [InventoryModal] = []
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
            Request.Parameter.user_id: currentUser?.id ?? String(),
        ]
        
        RequestManager.shared.requestPOST(requestMethod: Request.Method.inventoryListing, parameter: parameter, showLoader: false, decodingType: ResponseModal<[InventoryModal]>.self, successBlock: { (response: ResponseModal<[InventoryModal]>) in
            
            LoadingManager.shared.hideLoading()
            
            if response.code == Status.Code.success {
                
                self.items.append(contentsOf: response.data ?? [])
                self.itemCounts = self.items.count
                self.tblList.reloadData()
                
            } else {
                
                delay {
//                    DisplayAlertManager.shared.displayAlert(animated: true, message: response.message ?? String(), handlerOK: nil)
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
    
    @IBAction func btnAdd(_ sender: Any) {
        let vc = DailyInventoryVC.instantiate(fromAppStoryboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //------------------------------------------------------
    
    //MARK: TableView Delegate Datasource Method(s)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if items.count == 0 {
            self.tblList.setEmptyMessage("No data")
        } else {
            self.tblList.restore()
        }
        return itemCounts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: InventoryCell.self)) as? InventoryCell {
            cell.selectionStyle = .none
            let data = items[indexPath.row]
            cell.lblOrder.text = "Inventory Added Date: \(data.inventoryDate ?? String())"
            cell.lblName.text = "Inventory ID : \(data.inventoryID ?? String())"
            cell.lblTotal.text = "Employee ID : \(data.employeeID ?? String())"
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureUI()
        
        LoadingManager.shared.showLoading()
        
        self.performGetListing { (flag : Bool) in
            
        }
    }
    
    //------------------------------------------------------
}

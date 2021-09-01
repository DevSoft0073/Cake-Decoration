//
//  OnHandListingVC.swift
//  CakeDecoration
//
//  Created by MyMac on 8/22/21.
//
import UIKit
import Foundation

class OnHandListingVC : BaseVC, UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var tblLsit: UITableView!
    
    var items: [OnHandItems] = []
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
        
        let identifier = String(describing: ReadyCell.self)
        let nibCell = UINib(nibName: identifier, bundle: Bundle.main)
        tblLsit.register(nibCell, forCellReuseIdentifier: identifier)
        tblLsit.delegate = self
        tblLsit.dataSource = self
        tblLsit.separatorStyle = .none
    }
    
    func performGetListing(completion:((_ flag: Bool) -> Void)?) {
        
        self.items.removeAll()
        
        let parameter: [String: Any] = [
            Request.Parameter.user_id: currentUser?.id ?? String(),
        ]
        self.items.removeAll()
        RequestManager.shared.requestPOST(requestMethod: Request.Method.deltaData, parameter: parameter, showLoader: false, decodingType: ResponseModal<[OnHandItems]>.self, successBlock: { (response: ResponseModal<[OnHandItems]>) in
            
            LoadingManager.shared.hideLoading()
            
            if response.code == Status.Code.success {
                
                self.items.append(contentsOf: response.data ?? [])
                self.items = self.items.removingDuplicates()
                self.itemCounts = self.items.count
                self.tblLsit.reloadData()
                
            } else if response.code == Status.Code.notfound  {
                
                self.items.removeAll()
                self.tblLsit.reloadData()
                
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
    
    func performStatus(item_id : String , inventory_id : String ,completion:((_ flag: Bool) -> Void)?) {
        
        var parameter: [String: Any] = [:]
        
        parameter = [
            Request.Parameter.employee_id: currentUser?.id ?? String(),
            Request.Parameter.item_id : item_id,
            Request.Parameter.ready_status: "1",
            Request.Parameter.inventory_id : inventory_id
          
        ]
        
        RequestManager.shared.requestPOST(requestMethod: Request.Method.readyInventory, parameter: parameter, showLoader: false, decodingType: BaseResponseModal.self, successBlock: { (response: BaseResponseModal) in
            
            LoadingManager.shared.hideLoading()
            
            if response.code == Status.Code.success {
                
                delay {
                    DisplayAlertManager.shared.displayAlert(target: self, animated: true, message: response.message ?? String()) {
                        
                        delay {
                            
                            LoadingManager.shared.showLoading()
                            
                            self.performGetListing { (flag : Bool) in
                                
                            }
                        }
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

    
    //------------------------------------------------------
    
    //MARK: Action
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //------------------------------------------------------
    
    //MARK: TableView Delegate Datasource Method(s)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if items.count == 0 {
            self.tblLsit.setEmptyMessage("No data found!")
        } else {
            self.tblLsit.restore()
        }
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ReadyCell.self)) as? ReadyCell {
            cell.selectionStyle = .none
            let data = items[indexPath.row]
            cell.lblName.text = "Item Name:        \(data.itemName ?? String())"
            cell.lblDate.text = "Inventory Date:        \(data.inventoryDate ?? String())"
            cell.btnReady.addTarget(self, action: #selector(readyButtonAction(sender:)), for: .touchUpInside)
            cell.btnReady.tag = indexPath.row
            cell.btnReady.setTitle("Ready", for: .normal)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    //------------------------------------------------------
    
    //MARK: Table view button action
    
    @objc func readyButtonAction(sender : UIButton) {
        let data = items[sender.tag]
        
        DisplayAlertManager.shared.displayAlertWithCancelOk(target: self, animated: true, message: "Are you sure this order is ready?") {
            
        } handlerOk: {
            
            DispatchQueue.main.async {
                
                LoadingManager.shared.showLoading()
                
                self.performStatus(item_id: data.itemID ?? String(), inventory_id: data.inventoryID ?? String()) { (flag : Bool) in
                }
            }
        }
    }

    
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblLsit.separatorColor = .clear
        tblLsit.separatorStyle = .none
        
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

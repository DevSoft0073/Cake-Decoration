//
//  CustomerOrderListing.swift
//  CakeDecoration
//
//  Created by MyMac on 14/08/21.
//
import UIKit
import Foundation

class CustomerOrderListing : BaseVC , UITableViewDelegate , UITableViewDataSource{
    
    //------------------------------------------------------
    
    //MARK: IBOutlet(s)
    
    @IBOutlet weak var tblList: UITableView!
    
    var items: [OrderListingModal] = []
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
                
        let identifier = String(describing: CustomerListingCell.self)
        let nibCell = UINib(nibName: identifier, bundle: Bundle.main)
        tblList.register(nibCell, forCellReuseIdentifier: identifier)
        tblList.delegate = self
        tblList.dataSource = self
        tblList.separatorStyle = .none
    }
    
    func performGetListing(completion:((_ flag: Bool) -> Void)?) {
        
        let parameter: [String: Any] = [
            Request.Parameter.employeeId: currentUser?.id ?? String(),
            Request.Parameter.status : "1",
            Request.Parameter.month: "",
            Request.Parameter.week : "",
        ]
        
        RequestManager.shared.requestPOST(requestMethod: Request.Method.orderListing, parameter: parameter, showLoader: false, decodingType: ResponseModal<[OrderListingModal]>.self, successBlock: { (response: ResponseModal<[OrderListingModal]>) in
            
            LoadingManager.shared.hideLoading()
            
            if response.code == Status.Code.success {
                
                self.items.append(contentsOf: response.data ?? [])
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
    
    func performStatus(completion:((_ flag: Bool) -> Void)?) {
        
        RequestManager.shared.requestPOSTT(requestMethod: Request.Method.deliverStatus, showLoader: false, decodingType: ResponseModal<ReadyStatus>.self, successBlock: { (response: ResponseModal<ReadyStatus>) in
            
            LoadingManager.shared.hideLoading()
            
            if response.code == Status.Code.success {
                delay {
                    DisplayAlertManager.shared.displayAlert(target: self, animated: true, message: response.message ?? String()) {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
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
    
    //MARK: TableView Delegate Datasource Method(s)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if itemCounts == 0 {
            self.tblList.setEmptyMessage("No data")
        } else {
            self.tblList.restore()
        }
        return itemCounts
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CustomerListingCell.self)) as? CustomerListingCell {
            cell.selectionStyle = .none
            let data = items[indexPath.row]
            cell.lblOrder.text = "Order ID : \(data.orderID ?? String())"
            cell.cutomerName.text = "Customer name : \(data.name ?? String())"
            cell.LblDate.text = "Expected date : \(data.expectedOrderReady ?? String())"
            cell.lblTotalCOst.text = "Total Price : \(data.totalCost ?? String())"
            cell.btnDeliver.addTarget(self, action: #selector(readyButtonAction(sender:)), for: .touchUpInside)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 325
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    //------------------------------------------------------
    
    //MARK: Table view button action
    
    @objc func readyButtonAction(sender : UIButton) {
        
        DisplayAlertManager.shared.displayAlertWithNoYes(target: self, animated: true, message: "Are you sure want to deliver this order?") {
            
        } handlerYes: {
            DispatchQueue.main.async {
                
                LoadingManager.shared.showLoading()
                
                self.performStatus { (flag : Bool) in
                    
                }
            }

        }

        
//        DisplayAlertManager.shared.displayAlertWithCancelOk(target: self, animated: true, message: "Are you sure want to deliver this order?") {
            
//        } handlerOk: {
//
//            DispatchQueue.main.async {
//
//                LoadingManager.shared.showLoading()
//
//                self.performStatus { (flag : Bool) in
//
//                }
//            }
//
//        }
        
    }
    
    //------------------------------------------------------
    
    //MARK: Action
    
    @IBAction func brnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

//
//  OrderListingVC.swift
//  CakeDecoration
//
//  Created by MyMac on 08/08/21.
//
import UIKit
import Foundation

class OrderListingVC : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //------------------------------------------------------
    
    //MARK: IBOutlet(s)
    
    @IBOutlet weak var tblListing: UITableView!
    
    //------------------------------------------------------
    
    //MARK: Variable Declarations
    
    var items: [OrderListingModal] = []
    
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
                
        let identifier = String(describing: OrderListingCell.self)
        let nibCell = UINib(nibName: identifier, bundle: Bundle.main)
        tblListing.register(nibCell, forCellReuseIdentifier: identifier)
        tblListing.delegate = self
        tblListing.dataSource = self
        tblListing.separatorStyle = .none
    }
    
    
    func performGetListing(completion:((_ flag: Bool) -> Void)?) {
        
        let parameter: [String: Any] = [
            Request.Parameter.employeeId: "2",
            Request.Parameter.status : "2",
            Request.Parameter.month: "",
            Request.Parameter.week : "36",
        ]
        
        RequestManager.shared.requestPOST(requestMethod: Request.Method.orderListing, parameter: parameter, showLoader: false, decodingType: ResponseModal<[OrderListingModal]>.self, successBlock: { (response: ResponseModal<[OrderListingModal]>) in
            
            LoadingManager.shared.hideLoading()
            
            if response.code == Status.Code.success {
                
                self.items.append(contentsOf: response.data ?? [])
                self.tblListing.reloadData()
                
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
        
        let parameter: [String: Any] = [
            Request.Parameter.employeeId: "2",
            Request.Parameter.orderStatu : "2",
            Request.Parameter.order_id: "order610fc22e0dce1",
        ]
        
        RequestManager.shared.requestPOST(requestMethod: Request.Method.readyStatus, parameter: parameter, showLoader: false, decodingType: ResponseModal<ReadyStatus>.self, successBlock: { (response: ResponseModal<ReadyStatus>) in
            
            LoadingManager.shared.hideLoading()
            
            if response.code == Status.Code.success {
                delay {
                    DisplayAlertManager.shared.displayAlert(target: self, animated: true, message: response.message ?? String()) {
                        self.navigationController?.popViewController(animated: true)
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
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: OrderListingCell.self)) as? OrderListingCell {
            cell.selectionStyle = .none
            let data = items[indexPath.row]
            cell.lblOrder.text = "Order ID : \(data.orderID ?? String())"
            cell.lblName.text = "Customer name : \(data.name ?? String())"
            cell.lblDate.text = "Expected date : \(data.expectedOrderReady ?? String())"
            cell.lblTotal.text = "Total Price : \(data.totalCost ?? String())"
            cell.btnPay.addTarget(self, action: #selector(payButtonAction(sender:)), for: .touchUpInside)
            cell.btnReady.addTarget(self, action: #selector(readyButtonAction(sender:)), for: .touchUpInside)
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
    
    @objc func payButtonAction(sender : UIButton) {
        
        DisplayAlertManager.shared.displayAlertWithCancelOk(target: self, animated: true, message: "Are you sure this order price is paid?") {
            
        } handlerOk: {
            
        }
    }
    
    @objc func readyButtonAction(sender : UIButton) {
        
        DisplayAlertManager.shared.displayAlertWithCancelOk(target: self, animated: true, message: "Are you sure this order is ready?") {
            
        } handlerOk: {
            self.performStatus { (flag : Bool) in
                
            }
        }
    
    }
    
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        LoadingManager.shared.showLoading()
        
        delay {
            self.performGetListing { (flag : Bool) in
                self.configureUI()
            }
        }
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //------------------------------------------------------
}

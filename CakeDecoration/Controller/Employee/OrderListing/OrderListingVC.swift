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
        
    //------------------------------------------------------
    
    //MARK: Action
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //------------------------------------------------------
    
    //MARK: TableView Delegate Datasource Method(s)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: OrderListingCell.self)) as? OrderListingCell {
            cell.selectionStyle = .none
            cell.lblOrder.text = "Order ID : 236723234"
            cell.lblName.text = "Customer name : Mandeep Sharma"
            cell.lblDate.text = "Expected date : 08-Aug-2021"
            cell.lblTotal.text = "Total Price : $456"
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
            
        }
    
    }
    
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //------------------------------------------------------
}

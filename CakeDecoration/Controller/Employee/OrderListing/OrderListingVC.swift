//
//  OrderListingVC.swift
//  CakeDecoration
//
//  Created by MyMac on 08/08/21.
//
import UIKit
import Foundation

class OrderListingVC : BaseVC, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //------------------------------------------------------
    
    //MARK: IBOutlet(s)
    
    @IBOutlet weak var tblListing: UITableView!
    
    //------------------------------------------------------
    
    //MARK: Variable Declarations
    
    var items: [OrderListingModal] = []
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    var selectedArray = ["All","Week","Month"]
    var selectedValue = String()
    
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
        var monthName = String()
        var parameter: [String: Any] = [:]
        if selectedValue == "All" {
            parameter = [
                Request.Parameter.employeeId: "2",
                Request.Parameter.status : "1",
                Request.Parameter.month: "",
                Request.Parameter.week : "",
            ]
        } else if selectedValue == "Week" {
            parameter = [
                Request.Parameter.employeeId: "2",
                Request.Parameter.status : "2",
                Request.Parameter.month: "",
                Request.Parameter.week : "52",
            ]
            
        } else if selectedValue == "Month" {
            
            let now = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM"
            let nameOfMonth = dateFormatter.string(from: now)
            print(nameOfMonth)
            monthName = nameOfMonth
            
            parameter = [
                Request.Parameter.employeeId: "2",
                Request.Parameter.status : "3",
                Request.Parameter.month: monthName,
                Request.Parameter.week : "",
            ]
        } else {
            parameter = [
                Request.Parameter.employeeId: "2",
                Request.Parameter.status : "1",
                Request.Parameter.month: "",
                Request.Parameter.week : "",
            ]
        }
                
        RequestManager.shared.requestPOST(requestMethod: Request.Method.orderListing, parameter: parameter, showLoader: false, decodingType: ResponseModal<[OrderListingModal]>.self, successBlock: { (response: ResponseModal<[OrderListingModal]>) in
            
            LoadingManager.shared.hideLoading()
            
            if response.code == Status.Code.success {
                
                self.items.append(contentsOf: response.data ?? [])
                self.tblListing.reloadData()
                
            } else {
                
                delay {
//                    DisplayAlertManager.shared.displayAlert(animated: true, message: response.message ?? String(), handlerOK: nil)
                    self.items.removeAll()
                    self.tblListing.reloadData()
                }
            }
            
        }, failureBlock: { (error: ErrorModal) in
            
            LoadingManager.shared.hideLoading()
            
            delay {
                DisplayAlertManager.shared.displayAlert(animated: true, message: error.errorDescription, handlerOK: nil)
            }
        })
    }
    
    func performStatus(orderID : String , orderStatus : String ,completion:((_ flag: Bool) -> Void)?) {
        
        var parameter: [String: Any] = [:]
        
        parameter = [
            Request.Parameter.employeeId: currentUser?.id ?? String(),
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
    
    @IBAction func btnListing(_ sender: Any) {
        picker = UIPickerView.init()
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)
        
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .blackTranslucent
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonTapped() {
        
        LoadingManager.shared.showLoading()
        
        performGetListing { (flag : Bool) in
            
        }
        
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    
    //------------------------------------------------------
    
    //MARK: Picker view Delegate Datasource Method(s)
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return selectedArray.count
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return selectedArray[row]
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedValue = selectedArray[row]
        print(selectedArray[row])
    }
    
    //------------------------------------------------------
    
    //MARK: TableView Delegate Datasource Method(s)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if items.count == 0 {
            self.tblListing.setEmptyMessage("No data")
        } else {
            self.tblListing.restore()
        }
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: OrderListingCell.self)) as? OrderListingCell {
            cell.selectionStyle = .none
            let data = items[indexPath.row]
            cell.lblOrder.text = "Order ID : \(data.orderID ?? String())"
            cell.lblName.text = "Customer name : \(data.name ?? String())"
            cell.lblDate.text = "Ice Cream Flavour : \(data.iceCreamFlavour ?? String())"
            cell.lblType.text = "Cake Flavour : \(data.cakeFlavour ?? String())"
            let dateVal = NumberFormatter().number(from: data.expectedOrderReady ?? "")?.doubleValue ?? 0.0
            let timeStamp = self.convertTimeStampToDate(dateVal: dateVal)
            cell.lblDueDate.text = timeStamp
            cell.btnReady.addTarget(self, action: #selector(readyButtonAction(sender:)), for: .touchUpInside)
            cell.btnReady.tag = indexPath.row
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 335
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    //------------------------------------------------------
    
    //MARK: Table view button action
    
    @objc func readyButtonAction(sender : UIButton) {
        let data = items[sender.tag]
        DisplayAlertManager.shared.displayAlertWithCancelOk(target: self, animated: true, message: "Are you sure this order is ready?") {
            
        } handlerOk: {
            
            DispatchQueue.main.async {
                
                LoadingManager.shared.showLoading()
                
                self.performStatus(orderID: data.orderID ?? String(), orderStatus: data.orderReadyStatus ?? String()) { (flag : Bool) in
                }
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

extension UIViewController {
    func convertTimeStampToDate(dateVal : Double) -> String{
        let timeinterval = TimeInterval(dateVal)
        let dateFromServer = Date(timeIntervalSince1970:timeinterval)
        print(dateFromServer)
        let dateFormater = DateFormatter()
        dateFormater.timeZone = .current
        dateFormater.dateFormat = "d MMM yyyy"
        return dateFormater.string(from: dateFromServer)
    }
}

//
//  ListingVC.swift
//  CakeDecoration
//
//  Created by MyMac on 09/08/21.
//
import UIKit
import Foundation

class ListingVC : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var lblTitle: UILabel!
    
    //------------------------------------------------------
    
    //MARK: IBOutlet(s)
    
    @IBOutlet weak var tblList: UITableView!
    
    //------------------------------------------------------
    
    //MARK: Variable Declarations
    
    var userType: String = String()
    
    //------------------------------------------------------
    
    //MARK: Variable Declarations
    
//    var details:[HomeMenu] = [HomeMenu(type: .user, name: "Inventory", image: "inventory"),HomeMenu(type: .employee, name: "Cake List", image: "list")]
    
    var detailss:[HomeMenu] = [HomeMenu(type: .user, name: "Cake Order", image: "inventory"),HomeMenu(type: .employee, name: "Order Status", image: "list")]
    
    var details:[InventoryDetailsItems] = [InventoryDetailsItems(type: .add, name: "Item Listing", image: "inventory"),InventoryDetailsItems(type: .cakeList, name: "Inventory", image: "list"),InventoryDetailsItems(type: .inventory, name: "Cake list(By Orders)", image: "list"),InventoryDetailsItems(type: .delta, name: "Cake List(By Inventory)", image: "list")]
    
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
        
        let identifier = String(describing: HomeOptionsCell.self)
        let nibCell = UINib(nibName: identifier, bundle: Bundle.main)
        tblList.register(nibCell, forCellReuseIdentifier: identifier)
        tblList.delegate = self
        tblList.dataSource = self
        tblList.separatorStyle = .none
        
        if PreferenceManager.shared.curretMode == "1" {
            lblTitle.text = "Cake Management"
        }else{
            lblTitle.text = "Order Management"
        }
    }
    
    //------------------------------------------------------
    
    //MARK: Action
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //------------------------------------------------------
    
    //MARK: TableView Delegate Datasource Method(s)
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if PreferenceManager.shared.curretMode == "1"{
            return details.count
        }else{
            return detailss.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeOptionsCell.self)) as? HomeOptionsCell {
            cell.selectionStyle = .none
            
            if PreferenceManager.shared.curretMode == "1"{
                let product = details[indexPath.row]
                cell.imgType.image = UIImage(named: product.image)
                cell.lblType.text = product.name
                cell.mainVW.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 2.0, opacity: 0.35)
            }else{
                let product = detailss[indexPath.row]
                cell.imgType.image = UIImage(named: product.image)
                cell.lblType.text = product.name
                cell.mainVW.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 2.0, opacity: 0.35)
            }
                        
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if PreferenceManager.shared.curretMode == "1"{
            let type = details[indexPath.row].type
            if type == .add {
                let vc = AddedInventoryVC.instantiate(fromAppStoryboard: .Main)
                self.navigationController?.pushViewController(vc, animated: true)
            }else if type == .cakeList{
                let vc = DailyInventoryVC.instantiate(fromAppStoryboard: .Main)
                self.navigationController?.pushViewController(vc, animated: true)
            }else if type == .inventory {
                let vc = OrderListingVC.instantiate(fromAppStoryboard: .Main)
                self.navigationController?.pushViewController(vc, animated: true)
            } else if type == .delta {
                let vc = OnHandListingVC.instantiate(fromAppStoryboard: .Main)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else{
            let type = detailss[indexPath.row].type
            if type == .user {
                let vc = SubmitVC.instantiate(fromAppStoryboard: .Customer)
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = CustomerOrderListing.instantiate(fromAppStoryboard: .Customer)
                self.navigationController?.pushViewController(vc, animated: true)
            }
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

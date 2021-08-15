//
//  HomeListingVC.swift
//  CakeDecoration
//
//  Created by MyMac on 08/08/21.
//
import UIKit
import Foundation

class HomeListingVC : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    //------------------------------------------------------
    
    //MARK: IBOutlet(s)
    
    @IBOutlet weak var tblList: UITableView!
    
    //------------------------------------------------------
    
    //MARK: Variable Declarations
    
    var details:[HomeMenu] = [HomeMenu(type: .user, name: "Cake Decorator", image: "cake"),HomeMenu(type: .employee, name: "Cake Order", image: "order")]
    
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
    }
    
    //------------------------------------------------------
    
    //MARK: TableView Delegate Datasource Method(s)
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeOptionsCell.self)) as? HomeOptionsCell {
            cell.selectionStyle = .none
            let product = details[indexPath.row]
            cell.imgType.image = UIImage(named: product.image)
            cell.lblType.text = product.name
            cell.mainVW.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 2.0, opacity: 0.35)
            return cell
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = details[indexPath.row].type
        if type == .user {
            let vc = LoginInVC.instantiate(fromAppStoryboard: .Main)
            PreferenceManager.shared.curretMode = "1"
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = ListingVC.instantiate(fromAppStoryboard: .Main)
            PreferenceManager.shared.curretMode = "2"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //------------------------------------------------------
    
    //MARK: Actions
    
    @IBAction func btnMenu(_ sender: Any) {
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

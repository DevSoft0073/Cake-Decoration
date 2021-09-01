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
    
    func showAlertController(fromAdmin: Bool){
        let alert = UIAlertController(title: "Authentication Required!", message: "You need to enter your administrator password to continue.", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.isSecureTextEntry = true
            textField.placeholder = "Password"
        }
        alert .addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { [weak alert] (_) in}))
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            
            if textField?.text?.isEmpty == true {
                DisplayAlertManager.shared.displayAlert(message: "Please enter password")
            }else{
                LoadingManager.shared.showLoading()
                
                self.performSignIn(password: textField?.text ?? String()) { (flag : Bool) in
                    
                }
            }
            
        }))
    
        self.present(alert, animated: true, completion: nil)
    }
    
    func performSignIn(password : String ,completion:((_ flag: Bool) -> Void)?) {
        
        let parameter: [String: Any] = [
            Request.Parameter.role: PreferenceManager.shared.curretMode ?? String(),
            Request.Parameter.password: password,
        ]
        
        RequestManager.shared.requestPOST(requestMethod: Request.Method.login, parameter: parameter, showLoader: false, decodingType: ResponseModal<UserModal>.self, successBlock: { (response: ResponseModal<UserModal>) in
            
            LoadingManager.shared.hideLoading()
            
            if response.code == Status.Code.success {
                if let stringUser = try? response.data?.jsonString() {
                    PreferenceManager.shared.currentUser = stringUser
                }
                let vc = ListingVC.instantiate(fromAppStoryboard: .Main)
                self.navigationController?.pushViewController(vc, animated: true)
                
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
            PreferenceManager.shared.curretMode = "1"
            showAlertController(fromAdmin: type == .user)
        }else{
            PreferenceManager.shared.curretMode = "2"
            showAlertController(fromAdmin: type == .employee)
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

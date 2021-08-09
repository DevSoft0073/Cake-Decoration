//
//  LoginInVC.swift
//  CakeDecoration
//
//  Created by MyMac on 08/08/21.
//
import UIKit
import Foundation

class LoginInVC : UIViewController {
    
    
    //------------------------------------------------------
    
    //MARK: IBOutlet(s)
    
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    //------------------------------------------------------
    
    //MARK: Variable Declarations
    
    var userType: String = String()
    
    //------------------------------------------------------
    
    //MARK: Variable Declarations
    
    
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
    
    func performGetStudioDetails(completion:((_ flag: Bool) -> Void)?) {
        
        let parameter: [String: Any] = [
            Request.Parameter.email: txtEmail.text ?? String(),
            Request.Parameter.password : txtPassword.text ?? String(),
        ]
        
        RequestManager.shared.requestPOST(requestMethod: Request.Method.login, parameter: parameter, showLoader: false, decodingType: ResponseModal<UserModal>.self, successBlock: { (response: ResponseModal<UserModal>) in
            
            LoadingManager.shared.hideLoading()
            
            if response.code == Status.Code.success {
                
                
                if let stringUser = try? response.data?.jsonString() {
                    print(stringUser)
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
    
    //MARK: Actions
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        if PreferenceManager.shared.curretMode == "1"{
            let vc = ListingVC.instantiate(fromAppStoryboard: .Main)
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = ListingVC.instantiate(fromAppStoryboard: .Main)
            self.navigationController?.pushViewController(vc, animated: true)
        }
      
    }
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //------------------------------------------------------
}

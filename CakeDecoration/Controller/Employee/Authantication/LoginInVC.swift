//
//  LoginInVC.swift
//  CakeDecoration
//
//  Created by MyMac on 08/08/21.
//
import UIKit
import Foundation

class LoginInVC : BaseVC {
    
    
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
    
    
    func validate() -> Bool {
        
        if ValidationManager.shared.isEmpty(text: txtEmail.text) == true {
            DisplayAlertManager.shared.displayAlert(target: self, animated: true, message: LocalizableConstants.ValidationMessage.enterEmail) {
            }
            return false
        }
        
        if ValidationManager.shared.isValid(text: txtEmail.text!, for: RegularExpressions.email) == false {
            DisplayAlertManager.shared.displayAlert(target: self, animated: true, message: LocalizableConstants.ValidationMessage.enterValidEmail) {
            }
            return false
        }
        
        if ValidationManager.shared.isEmpty(text: txtPassword.text) == true {
            DisplayAlertManager.shared.displayAlert(target: self, animated: true, message: LocalizableConstants.ValidationMessage.enterPassword) {
            }
            return false
        }
        
        return true
    }
    
    func performSignIn(completion:((_ flag: Bool) -> Void)?) {
        
        let parameter: [String: Any] = [
            Request.Parameter.name: txtEmail.text ?? String(),
            Request.Parameter.password : txtPassword.text ?? String(),
            Request.Parameter.role: PreferenceManager.shared.curretMode ?? String()
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
    
    //MARK: Actions
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        if PreferenceManager.shared.curretMode == "1"{
            
            if validate() == false {
                return
            }
            
            self.view.endEditing(true)
            
            LoadingManager.shared.showLoading()
            
            delay {
                self.performSignIn { (flag : Bool) in
//                    let vc = ListingVC.instantiate(fromAppStoryboard: .Main)
//                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }else{
            
            if validate() == false {
                return
            }
            
            self.view.endEditing(true)
            
            LoadingManager.shared.showLoading()
            
            delay {
                self.performSignIn { (flag : Bool) in
//                    let vc = ListingVC.instantiate(fromAppStoryboard: .Main)
//                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.text = "komal@gmail.com"
        txtPassword.text = "12345678"
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //------------------------------------------------------
}

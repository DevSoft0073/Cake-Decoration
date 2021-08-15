//
//  LoginInVC.swift
//  CakeDecoration
//
//  Created by MyMac on 08/08/21.
//
import UIKit
import Foundation

class LoginInVC : BaseVC , UIPickerViewDelegate, UITextFieldDelegate ,UIPickerViewDataSource {
    
    
    //------------------------------------------------------
    
    //MARK: IBOutlet(s)
    
    @IBOutlet weak var txtEmail: UITextField!
    
    //------------------------------------------------------
    
    //MARK: Variable Declarations
    
    var userType: String = String()
    var items: [EmployeeModal] = []
    var nameArray = [String]()
    
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
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        createPickerView()
        dismissPickerView()
    }

    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        txtEmail.inputView = pickerView
    }
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        txtEmail.inputAccessoryView = toolBar
        
    }
    @objc func action() {
        view.endEditing(true)
    }
    
    func performGetAllEmployees(completion:((_ flag: Bool) -> Void)?) {
        
        RequestManager.shared.requestPOSTT(requestMethod: Request.Method.allEmployees, showLoader: false, decodingType: ResponseModal<[EmployeeModal]>.self, successBlock: { (response: ResponseModal<[EmployeeModal]>) in
            
            LoadingManager.shared.hideLoading()
            
            if response.code == Status.Code.success {
                
                self.items.append(contentsOf: response.data ?? [])
                for obj in self.items {
                    self.nameArray.append(obj.name ?? "")
                }
                
            } else {
                
            }
            
        }, failureBlock: { (error: ErrorModal) in
            
            LoadingManager.shared.hideLoading()

        })
    }
    
    func performSignIn(completion:((_ flag: Bool) -> Void)?) {
        
        let parameter: [String: Any] = [
            Request.Parameter.name: txtEmail.text ?? String(),
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1 // number of session
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return items.count
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtEmail.text = items[row].name
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

        LoadingManager.shared.showLoading()
        
        self.performGetAllEmployees { (flag : Bool) in
            
        }
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //------------------------------------------------------
}

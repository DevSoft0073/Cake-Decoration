//
//  SubmitVC.swift
//  CakeDecoration
//
//  Created by MyMac on 08/08/21.
//
import UIKit
import Foundation

class SubmitVC : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource ,UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    //------------------------------------------------------
    
    //MARK: IBOutlet(s)
    
    @IBOutlet weak var txtSelectedDate: UITextField!
    @IBOutlet weak var txtEmpName: UITextField!
    @IBOutlet weak var collectionFlavour: UICollectionView!
    @IBOutlet weak var collectionGuests: UICollectionView!
    
    //------------------------------------------------------
    
    //MARK: Variable Declarations
    
    var items: [EmployeeModal] = []
    
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
    
    func configureUI() {
        collectionGuests.delegate = self
        collectionGuests.dataSource = self
        var identifier = String(describing: GusestsListCell.self)
        var nibCell = UINib(nibName: identifier, bundle: Bundle.main)
        collectionGuests.register(nibCell, forCellWithReuseIdentifier: identifier)
        
        identifier = String(describing: FlavourCell.self)
        nibCell = UINib(nibName: identifier, bundle: Bundle.main)
        collectionFlavour.register(nibCell, forCellWithReuseIdentifier: identifier)
    }
    
    func performGetAllEmployees(completion:((_ flag: Bool) -> Void)?) {
        
        RequestManager.shared.requestPOSTT(requestMethod: Request.Method.allEmployees, showLoader: false, decodingType: ResponseModal<[EmployeeModal]>.self, successBlock: { (response: ResponseModal<[EmployeeModal]>) in
            
            LoadingManager.shared.hideLoading()
            
            if response.code == Status.Code.success {
                
                self.items.append(contentsOf: response.data ?? [])
                
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        createPickerView()
        dismissPickerView()
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        txtEmpName.inputView = pickerView
    }
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        txtEmpName.inputAccessoryView = toolBar
    }
    @objc func action() {
        view.endEditing(true)
    }
    
    @objc func doneButtonPressed() {
        if let  datePicker = self.txtSelectedDate.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            self.txtSelectedDate.text = dateFormatter.string(from: datePicker.date)
        }
        self.txtSelectedDate.resignFirstResponder()
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // number of session
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count // number of dropdown items
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[row].name // dropdown item
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        selectedCountry = countryList[row] // selected item
//        textFiled.text = selectedCountry
        txtEmpName.text = items[row].name
    }
    
    //------------------------------------------------------
    
    //MARK: CollectionView Delegate Datasource Method(s)
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionFlavour {
            return 12
            
        }else {
            return 12
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = 5
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionGuests {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GusestsListCell", for: indexPath) as! GusestsListCell
            return cell
        } else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlavourCell", for: indexPath) as! FlavourCell
            return cell
        }
    }
    
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        txtEmpName.delegate = self
        txtSelectedDate.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))

        performGetAllEmployees { (flag : Bool) in
            
        }
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //------------------------------------------------------
}

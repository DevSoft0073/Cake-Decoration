//
//  SubmitVC.swift
//  CakeDecoration
//
//  Created by MyMac on 08/08/21.
//
import UIKit
import Foundation

class SubmitVC : BaseVC, UICollectionViewDelegate, UICollectionViewDataSource ,UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate ,ImagePickerDelegate{
    
    //------------------------------------------------------
    
    //MARK: IBOutlet(s)
    
    @IBOutlet weak var flvrViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collHeight: NSLayoutConstraint!
    @IBOutlet weak var guestHeight: NSLayoutConstraint!
    @IBOutlet weak var lblUploadedImage: UILabel!
    @IBOutlet weak var txtSelectFlvOur: UITextField!
    @IBOutlet weak var txtSelectCrust: UITextField!
    @IBOutlet weak var txtSelextRoll: UITextField!
    @IBOutlet weak var txtMessageView: UITextView!
    @IBOutlet weak var txtBalance: UITextField!
    @IBOutlet weak var txtDepositePaid: UITextField!
    @IBOutlet weak var txtTotalCodt: UITextField!
    @IBOutlet weak var txtCandles: UITextField!
    @IBOutlet weak var txtSpecial: UITextField!
    @IBOutlet weak var txtDecoSet: UITextField!
    @IBOutlet weak var txtCakePrice: UITextField!
    @IBOutlet weak var txtBdayName: UITextField!
    @IBOutlet weak var txtFrosting: UITextField!
    @IBOutlet weak var txtEvengDay: UITextField!
    @IBOutlet weak var txtPhoneDay: UITextField!
    @IBOutlet weak var imgann: UIImageView!
    @IBOutlet weak var imgCongrts: UIImageView!
    @IBOutlet weak var imgBday: UIImageView!
    @IBOutlet weak var txtSelectTIme: UITextField!
    @IBOutlet weak var txtSelectDay: UITextField!
    @IBOutlet weak var imgFrostingColor: UIImageView!
    @IBOutlet weak var imgAdult: UIImageView!
    @IBOutlet weak var imgChild: UIImageView!
    @IBOutlet weak var imgSurprise: UIImageView!
    @IBOutlet weak var txtCakeName: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPickOrder: UITextField!
    @IBOutlet weak var txtSelectedDate: UITextField!
    @IBOutlet weak var txtEmpName: UITextField!
    @IBOutlet weak var collectionFlavour: UICollectionView!
    @IBOutlet weak var collectionGuests: UICollectionView!
    
    //------------------------------------------------------
    
    //MARK: Variable Declarations
    var white = true
    var surprise = true
    var color = true
    var adult = true
    var celeberation = "1"
    var empId = String()
    var items: [EmployeeModal] = []
    var selectedGuest = String()
    var selectedFlavour = String()
    var dayArray = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    var selectTime = ["10am", "11am", "12pm", "1pm", "2pm", "3pm", "4pm","5pm","6pm","7pm","8pm","9pm"]
    
    var rollCakeArray = ["Vanila/Chocolate","Mint Chip/Chocolate","Oero/Chocolate","Chocolate/Chocolate"]
    var curstArray = ["Browine", "Chocolate Chip"]
    var cakeFlv = ["White","Chocolate"]
    
    var flavourArray : [NSMutableDictionary] = [["name" : "Chocolate Chip Chocloate" , "isSelected" : false],["name" : "MintChip/Chocolate" , "isSelected" : false],["name" : "Vanila/Chocolate" , "isSelected" : false],["name" : "Oreo/White" , "isSelected" : false],["name" : "Pralines N Cream/White" , "isSelected" : false],["name" : "Strawberry/White" , "isSelected" : false],["name" : "Oreo/Chocolate" , "isSelected" : false],["name" : "Fudge Crunch" , "isSelected" : false]]
    
    var guestArray : [NSMutableDictionary] = [["name" : "1/2 Roll Cake (2-4)","isSelected" : false],["name" : "1/2 Roll Cake (2-4)","isSelected" : false],["name" : "1/4 (4-4)","isSelected" : false],["name" : "6'' Rpund (6-8)","isSelected" : false],["name" : "1/3 (6-8)","isSelected" : false],["name" : "Roll Cake (6-8)","isSelected" : false],["name" : "Pie (6-9)","isSelected" : false],["name" : "Fudge Nut (8-10)","isSelected" : false],["name" : "1/2 (8-12)","isSelected" : false],["name" : "Large Heart (10-12)","isSelected" : false],["name" : "2/3 (12-16)","isSelected" : false],["name" : "9'' Round (12-16)","isSelected" : false],["name" : "Full (16-24)","isSelected" : false],["name" : "Full + 1/3(24-32)","isSelected" : false],["name" : "Full + 1/2 (30-36)","isSelected" : false],["name" : "Dbl Full (36-48)","isSelected" : false],["name" : "Polar Pizza (8)","isSelected" : false],["name" : "Cookie Cake (8-12)","isSelected" : false],["name" : "Torte (8-10)","isSelected" : false],["name" : "Mini Heart (2-4)","isSelected" : false],["name" : "Mini two Tiered Round (xx)","isSelected" : false],["name" : "Two Tiered Round (18-24)","isSelected" : false],["name" : "Other","isSelected" : false]]
    
    var suprise = String()
    var bday = String()
    var ann = String()
    var congrts = String()
    var selectedGuestCount = -1
    var selectedFlvCount = -1
    var imgData = String()
    var imagePickerVC: ImagePicker?
    var selectedImage: UIImage? {
        didSet {
            if selectedImage != nil {
//                imgProfile.image = selectedImage
            }
        }
    }
    
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
        
        imagePickerVC = ImagePicker(presentationController: self, delegate: self)
        
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
        
        if textField == txtEmpName {
            txtEmpName.isSelected = true
            txtSelectDay.isSelected = false
            txtSelectTIme.isSelected = false
            txtSelectFlvOur.isSelected = false
            txtSelectCrust.isSelected = false
            txtSelextRoll.isSelected = false
            
        } else if textField == txtSelectDay {
            txtEmpName.isSelected = false
            txtSelectDay.isSelected = true
            txtSelectTIme.isSelected = false
            txtSelectFlvOur.isSelected = false
            txtSelectCrust.isSelected = false
            txtSelextRoll.isSelected = false
            
        } else if textField == txtSelectTIme {
            txtEmpName.isSelected = false
            txtSelectDay.isSelected = false
            txtSelectTIme.isSelected = true
            txtSelectFlvOur.isSelected = false
            txtSelectCrust.isSelected = false
            txtSelextRoll.isSelected = false
            
        } else if textField == txtSelectFlvOur {
            txtEmpName.isSelected = false
            txtSelectDay.isSelected = false
            txtSelectTIme.isSelected = false
            txtSelectFlvOur.isSelected = true
            txtSelectCrust.isSelected = false
            txtSelextRoll.isSelected = false
            
        } else if textField == txtSelectCrust {
            
            txtEmpName.isSelected = false
            txtSelectDay.isSelected = false
            txtSelectTIme.isSelected = false
            txtSelectFlvOur.isSelected = false
            txtSelectCrust.isSelected = true
            txtSelextRoll.isSelected = false
            
        } else if textField == txtSelextRoll {
            txtEmpName.isSelected = false
            txtSelectDay.isSelected = false
            txtSelectTIme.isSelected = false
            txtSelectFlvOur.isSelected = false
            txtSelectCrust.isSelected = false
            txtSelextRoll.isSelected = true
        }
        createPickerView()
        dismissPickerView()
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        txtEmpName.inputView = pickerView
        txtSelectDay.inputView = pickerView
        txtSelectTIme.inputView = pickerView
        txtSelectFlvOur.inputView = pickerView
        txtSelectCrust.inputView = pickerView
        txtSelextRoll.inputView = pickerView
    }
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        txtEmpName.inputAccessoryView = toolBar
        txtSelectDay.inputAccessoryView = toolBar
        txtSelectTIme.inputAccessoryView = toolBar
        txtSelectFlvOur.inputAccessoryView = toolBar
        txtSelectCrust.inputAccessoryView = toolBar
        txtSelextRoll.inputAccessoryView = toolBar
        
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
        if txtEmpName.isSelected == true {
            return items.count
        } else if txtSelectDay.isSelected == true {
            return dayArray.count
        } else if txtSelectTIme.isSelected == true {
            return selectTime.count
        } else if txtSelectFlvOur.isSelected == true {
            return cakeFlv.count
        } else if txtSelectCrust.isSelected == true {
            return curstArray.count
        } else if txtSelextRoll.isSelected == true {
            return rollCakeArray.count
        }
        return items.count // number of dropdown items
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
        
        if txtEmpName.isSelected == true {
            return items[row].name
        } else if txtSelectDay.isSelected == true {
            return dayArray[row]
        } else if txtSelectTIme.isSelected == true {
            return selectTime[row]
        } else if txtSelectFlvOur.isSelected == true {
            return cakeFlv[row]
        } else if txtSelectCrust.isSelected == true {
            return curstArray[row]
        } else if txtSelextRoll.isSelected == true {
            return rollCakeArray[row]
        }
        return items[row].name // dropdown item
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if txtEmpName.isSelected == true {
            txtEmpName.text = items[row].name
            empId = items[row].id ?? String()
        } else if txtSelectDay.isSelected == true {
            txtSelectDay.text = dayArray[row]
        } else if txtSelectTIme.isSelected == true {
            txtSelectTIme.text = selectTime[row]
        } else if txtSelectFlvOur.isSelected == true {
            txtSelectFlvOur.text = cakeFlv[row]
        } else if txtSelectCrust.isSelected == true {
            txtSelectCrust.text = curstArray[row]
        } else if txtSelextRoll.isSelected == true {
            txtSelextRoll.text = rollCakeArray[row]
        }
    }
    
    func getCount(isGuest : Bool) {
        if isGuest {
            var index = 0
            for obj in guestArray {
                if index == selectedGuestCount {
                    obj["isSelected"] = true
                } else {
                    obj["isSelected"] = false
                }
                index += 1
            }
            DispatchQueue.main.async {
                self.collectionGuests.reloadData()
            }
        } else {
            var index = 0
            for obj in flavourArray {
                if index == selectedFlvCount {
                    obj["isSelected"] = true
                } else {
                    obj["isSelected"] = false
                }
                index += 1
            }
            DispatchQueue.main.async {
                self.collectionFlavour.reloadData()
            }
        }
    }
    
    func validateData() {
        if txtEmpName.text?.isEmpty == true {
            DisplayAlertManager.shared.displayAlert(message: "Please select employee name.")
            
        } else if txtSelectDay.text?.isEmpty == true{
            
            DisplayAlertManager.shared.displayAlert(message: "Please select day name.")
            
        } else if txtSelectTIme.text?.isEmpty == true{
            
            DisplayAlertManager.shared.displayAlert(message: "Please select time.")
            
        } else if txtName.text?.isEmpty == true{
            
            DisplayAlertManager.shared.displayAlert(message: "Please enter name.")
            
        } else if selectedGuest.isEmpty == true{
            
            DisplayAlertManager.shared.displayAlert(message: "Please select guest value.")
            
        } else if selectedFlavour.isEmpty == true{
            
            DisplayAlertManager.shared.displayAlert(message: "Please select flavour name.")
            
        } else if txtCakeName.text?.isEmpty == true{
            
            DisplayAlertManager.shared.displayAlert(message: "Please enter cake name.")
            
        } else if txtFrosting.text?.isEmpty == true{
            
            DisplayAlertManager.shared.displayAlert(message: "Please enter frosting colour.")
            
        } else if txtBdayName.text?.isEmpty == true{
            
            DisplayAlertManager.shared.displayAlert(message: "Please enter name for write on cake.")
            
        } else if txtSelectFlvOur.text?.isEmpty == true{
            
            DisplayAlertManager.shared.displayAlert(message: "Please select cake flavour.")
            
        } else if txtSelectCrust.text?.isEmpty == true{
            
            DisplayAlertManager.shared.displayAlert(message: "Please select curst name.")
            
        } else if txtSelextRoll.text?.isEmpty == true{
            
            DisplayAlertManager.shared.displayAlert(message: "Please select cake roll name.")
            
        } else if txtMessageView.text?.isEmpty == true{
            
            DisplayAlertManager.shared.displayAlert(message: "Please enter message text.")
            
        } else if txtBdayName.text?.isEmpty == true {
            
            DisplayAlertManager.shared.displayAlert(message: "Please enter age.")
            
        } else{
            
            LoadingManager.shared.showLoading()
            
            performAddOrder { (flag : Bool) in
                self.lblUploadedImage.text = "Upload Photo"
                self.lblUploadedImage.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
    }
    
    func performAddOrder(completion:((_ flag: Bool) -> Void)?) {
        
        let parameter: [String: Any] = [
            Request.Parameter.name: txtEmpName.text ?? String(),
            Request.Parameter.email : currentUser?.email ?? String(),
            Request.Parameter.ordered_date: "",
            Request.Parameter.order_time: txtSelectTIme.text ?? String(),
            Request.Parameter.order_day: txtSelectDay.text ?? String(),
            Request.Parameter.employeeId: empId,
            Request.Parameter.phone_day: txtPhoneDay.text ?? String(),
            Request.Parameter.phone_evening: txtPhoneDay.text ?? String(),
            Request.Parameter.order_surprise: suprise,
            Request.Parameter.order_pick: txtPhoneDay.text ?? String(),
            Request.Parameter.total_guest: selectedGuest,
            Request.Parameter.ice_cream_flavour: selectedFlavour,
            Request.Parameter.cake_flavour: txtSelectFlvOur.text ?? String(),
            Request.Parameter.crust: txtSelectCrust.text ?? String(),
            Request.Parameter.roll_cake_flavour: txtSelextRoll.text ?? String(),
            Request.Parameter.age: txtBdayName.text ?? String(),
            Request.Parameter.cake_name: txtPhoneDay.text ?? String(),
            Request.Parameter.frosting_color: txtPhoneDay.text ?? String(),
            Request.Parameter.message: txtMessageView.text ?? String(),
            Request.Parameter.birthday: bday,
            Request.Parameter.congratulation: congrts,
            Request.Parameter.anniversary: ann,
            Request.Parameter.cake_price: txtCakePrice.text ?? String(),
            Request.Parameter.photo_cake_price: txtPhoneDay.text ?? String(),
            Request.Parameter.actual_total: txtPhoneDay.text ?? String(),
            Request.Parameter.special_design_price: txtSpecial.text ?? String(),
            Request.Parameter.candles: txtCandles.text ?? String(),
            Request.Parameter.total_cost: txtTotalCodt.text ?? String(),
            Request.Parameter.deposit_paid: txtDepositePaid.text ?? String(),
            Request.Parameter.balance: txtBalance.text ?? String(),
            Request.Parameter.expected_order_ready: txtSelectTIme.text ?? String(),
            Request.Parameter.photo: imgData,
            Request.Parameter.user_id: currentUser?.id ?? String()

        ]
        
        RequestManager.shared.requestPOST(requestMethod: Request.Method.addOrder, parameter: parameter, showLoader: false, decodingType: BaseResponseModal.self, successBlock: { (response: BaseResponseModal) in
            
            LoadingManager.shared.hideLoading()
            
            if response.code == Status.Code.success {
                
                delay {
                    
                    DispatchQueue.main.async {
                        DisplayAlertManager.shared.displayAlert(target: self, animated: true, message: response.message ?? String()) {
                            self.pop()
                        }
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
    
    //MARK: SCImagePickerDelegate
    
    func didSelect(image: UIImage?) {
        if let imageData = image?.jpegData(compressionQuality: 0), let _ = UIImage(data: imageData) {
            imgData = imageData.base64EncodedString(options: .lineLength64Characters)
            lblUploadedImage.text = "Image Uploaded."
            lblUploadedImage.textColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        }
    }
    
    //------------------------------------------------------
    
    //MARK: Actions
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnUploadImg(_ sender: UIButton) {
        self.imagePickerVC?.present(from: sender)
    }
    
    @IBAction func btnSurprise(_ sender: Any) {
        if surprise == true {
            surprise = false
            suprise = "1"
            imgSurprise.image = UIImage(named: "check")
        } else {
            surprise = true
            suprise = "0"
            imgSurprise.image = UIImage(named: "uncheck")
        }
    }
    
    @IBAction func btnChild(_ sender: Any) {
        if adult == true {
            adult = false
            imgChild.image = UIImage(named: "check")
            imgAdult.image = UIImage(named: "uncheck")
        } else {
            adult = true
            imgChild.image = UIImage(named: "uncheck")
            imgAdult.image = UIImage(named: "check")
        }
    }
    
    @IBAction func btnBdayCelb(_ sender: UIButton) {
        if sender.tag == 1{
            bday = "1"
            congrts = "0"
            ann = "0"
            imgBday.image = UIImage(named: "check")
            imgCongrts.image = UIImage(named: "uncheck")
            imgann.image = UIImage(named: "uncheck")

        } else if sender.tag == 2 {
            bday = "0"
            congrts = "1"
            ann = "0"
            imgBday.image = UIImage(named: "uncheck")
            imgCongrts.image = UIImage(named: "check")
            imgann.image = UIImage(named: "uncheck")
             
        } else if sender.tag == 3 {
            bday = "0"
            congrts = "0"
            ann = "1"
            imgBday.image = UIImage(named: "uncheck")
            imgCongrts.image = UIImage(named: "uncheck")
            imgann.image = UIImage(named: "check")
            
        }
    }
    @IBAction func btnPlaceOrder(_ sender: Any) {
                
        validateData()
        
    }
    
    //------------------------------------------------------
    
    //MARK: CollectionView Delegate Datasource Method(s)
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionFlavour {
            return flavourArray.count
        }else {
            return guestArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = 3
        
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
            cell.lblType.text = guestArray[indexPath.item]["name"] as? String
            cell.layer.borderWidth = 2
            cell.layer.borderColor = UIColor.darkGray.cgColor
            cell.layer.cornerRadius = 5
            if selectedGuestCount == indexPath.item {
                cell.layer.borderColor = UIColor.systemTeal.cgColor
            } else {
                cell.layer.borderColor = UIColor.darkGray.cgColor
            }
            return cell
        } else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlavourCell", for: indexPath) as! FlavourCell
            cell.lblName.text = flavourArray[indexPath.item]["name"] as? String
            cell.layer.borderWidth = 2
            cell.layer.borderColor = UIColor.darkGray.cgColor
            cell.layer.cornerRadius = 5
            if selectedFlvCount == indexPath.item {
                cell.layer.borderColor = UIColor.systemTeal.cgColor
            } else {
                cell.layer.borderColor = UIColor.darkGray.cgColor
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionGuests{
            let data = guestArray[indexPath.item]
            self.selectedGuestCount = indexPath.item
            self.selectedGuest = data["name"] as! String
            self.getCount(isGuest: true)
        } else {
            let data = flavourArray[indexPath.item]
            self.selectedFlvCount = indexPath.item
            self.selectedFlavour = data["name"] as! String
            self.getCount(isGuest: false)
        }
    }
    
    func collectionView(_collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: IndexPath) {
        
        let cell = collectionFlavour.cellForItem(at: indexPath) as! FlavourCell
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.black.cgColor
    }
    
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        txtEmpName.delegate = self
        txtSelectDay.delegate = self
        txtSelectTIme.delegate = self
        txtSelectFlvOur.delegate = self
        txtSelectCrust.delegate = self
        txtSelextRoll.delegate = self
        txtSelectedDate.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))

        performGetAllEmployees { (flag : Bool) in
            
        }
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.guestHeight.constant = self.collectionGuests.contentSize.height + 40
            self.collHeight.constant = self.collectionFlavour.contentSize.height + 40
            self.flvrViewHeight.constant = self.collHeight.constant + 280
        }
    }
    
    //------------------------------------------------------
}

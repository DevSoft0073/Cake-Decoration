//
//  ShowSubmitDetailsVC.swift
//  CakeDecoration
//
//  Created by MyMac on 16/08/21.
//
import UIKit
import Foundation

class ShowSubmitDetailsVC : BaseVC {
    
    
    @IBOutlet weak var lblFlvr: UILabel!
    @IBOutlet weak var lblGuest: UILabel!
    @IBOutlet weak var imgSurprise: UIImageView!
    @IBOutlet weak var txtDeco: UITextField!
    @IBOutlet weak var txtBalance: UITextField!
    @IBOutlet weak var txtDepo: UITextField!
    @IBOutlet weak var txtTotal: UITextField!
    @IBOutlet weak var txtCandles: UITextField!
    @IBOutlet weak var txtSpecial: UITextField!
    @IBOutlet weak var txtCakePrice: UITextField!
    @IBOutlet weak var txtMsg: UITextView!
    @IBOutlet weak var imgAnn: UIImageView!
    @IBOutlet weak var imgCongrts: UIImageView!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var imgBday: UIImageView!
    @IBOutlet weak var txtFrostingColor: UITextField!
    @IBOutlet weak var txtCakeName: UITextField!
    @IBOutlet weak var imgAdult: UIImageView!
    @IBOutlet weak var imgChild: UIImageView!
    @IBOutlet weak var txtSelectRoll: UITextField!
    @IBOutlet weak var txtSelectCrust: UITextField!
    @IBOutlet weak var txtCakeFlvr: UITextField!
    @IBOutlet weak var txtCreamFlvr: UITextField!
    @IBOutlet weak var txtPickOrder: UITextField!
    @IBOutlet weak var txtPHEveng: UITextField!
    @IBOutlet weak var txtPHDay: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtTime: UITextField!
    @IBOutlet weak var txtDay: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtEmpName: UITextField!
    var orderDetail: OrderListingModal?
    
    //------------------------------------------------------
    
    //MARK: Memory Management Method
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //------------------------------------------------------
    
    deinit { //same like dealloc in ObjectiveC
        
    }
    
    //------------------------------------------------------
    
    //MARK: Cutome
    
    func setupUI() {
        txtEmpName.text = orderDetail?.name
        txtDate.text = orderDetail?.orderedDate
        txtDay.text = orderDetail?.orderDay
        txtTime.text = orderDetail?.orderTime
        txtName.text = orderDetail?.name
        txtPHDay.text = orderDetail?.phoneDay
        txtPHEveng.text = orderDetail?.phoneEvening
        txtPickOrder.text = orderDetail?.orderPick
        txtCakeFlvr.text = orderDetail?.cakeFlavour
        txtCreamFlvr.text = orderDetail?.iceCreamFlavour
        txtSelectCrust.text = orderDetail?.crust
        txtSelectRoll.text = orderDetail?.rollCakeFlavour
        txtCakeName.text = orderDetail?.cakeName
        txtFrostingColor.text = orderDetail?.frostingColor
        txtAge.text = orderDetail?.ageGroup
        txtMsg.text = orderDetail?.message
        txtCakePrice.text = orderDetail?.cakePrice
        txtSpecial.text = orderDetail?.specialDesignPrice
        txtDeco.text = orderDetail?.depositPaid
        txtCandles.text = orderDetail?.candles
        txtTotal.text = orderDetail?.totalCost
        txtBalance.text = orderDetail?.balance
        txtDepo.text = orderDetail?.balance
        if orderDetail?.orderSurprise == "1" {
            imgSurprise.image = UIImage(named: "check")
        }
        if  orderDetail?.ageGroup?.isEmpty == true {
            imgBday.image = UIImage(named: "uncheck")
        } else {
            imgBday.image = UIImage(named: "check")
        }
        lblFlvr.text = orderDetail?.cakeFlavour
        lblGuest.text = orderDetail?.totalGuest
    }
    
    //------------------------------------------------------
    
    //MARK: Action
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //------------------------------------------------------
}

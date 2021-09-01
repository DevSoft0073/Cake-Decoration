//
//  DetailsVC.swift
//  CakeDecoration
//
//  Created by MyMac on 8/20/21.
//
import UIKit
import Foundation
import SDWebImage

class DetailsVC : UIViewController {
    
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var lblCakeFlvr: UILabel!
    @IBOutlet weak var lblIceFlvr: UILabel!
    @IBOutlet weak var lblFlvor: UILabel!
    @IBOutlet weak var lblGuest: UILabel!
    @IBOutlet weak var lblDayTime: UILabel!
    @IBOutlet weak var imgCake: UIImageView!
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
    
    //MARK: Custome
    
    func setupUI() {
        lblMsg.text = "Bday Message:-         \(orderDetail?.message ?? String())"
        lblGuest.text = "How many Guest?:-         \(orderDetail?.totalGuest ?? String())"
        lblFlvor.text = "Flavor (Roll Cake):-         \(orderDetail?.rollCakeFlavour ?? String())"
        lblCakeFlvr.text = "Ice cream Flavor:-         \(orderDetail?.cakeFlavour ?? String())"
        lblIceFlvr.text = "Cake Flavor:-         \(orderDetail?.iceCreamFlavour ?? String())"
        lblDayTime.text = "Day/Time:-         \(orderDetail?.orderDay ?? String())" + "\(orderDetail?.orderTime ?? String())"
        imgCake.sd_setImage(with: URL(string:orderDetail?.photo ?? String()), placeholderImage: UIImage(named: "y9DpT"), options: SDWebImageOptions.continueInBackground, completed: nil)
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

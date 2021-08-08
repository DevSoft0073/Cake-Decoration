//
//  LandingVC.swift
//  CakeDecoration
//
//  Created by MyMac on 08/08/21.
//
import UIKit
import Foundation

class LandingVC : UIViewController {
    
    //------------------------------------------------------
    
    //MARK: IBOutlet(s)
    
    @IBOutlet weak var imgLogo: UIImageView!
    
    //------------------------------------------------------
    
    //MARK: Memory Management Method
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //------------------------------------------------------
    
    deinit { //same like dealloc in ObjectiveC
        
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
    
    //MARK: Make Animation
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.6) {
            self.imgLogo.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        } completion: { val in
            UIView.animate(withDuration: 0.6) {
                self.imgLogo.transform = CGAffineTransform.identity
            } completion: { _ in
                print("navigate forward")
                let vc = HomeListingVC.instantiate(fromAppStoryboard: .Main)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    
    //------------------------------------------------------
}

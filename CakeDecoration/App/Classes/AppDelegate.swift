//
//  AppDelegate.swift
//  CakeDecoration
//
//  Created by MyMac on 08/08/21.
//



import UIKit
import IQKeyboardManagerSwift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{
    
    var window: UIWindow?
    var userid = String()
    
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    /// keyboard configutation
    private func configureKeboard() {
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.toolbarPreviousNextAllowedClasses = [UIScrollView.self, UIStackView.self, UIView.self, UISearchBar.self]
    }
    
  
//    func chekLoggedUser() {
//        if PreferenceManager.shared.loggedUser == true {
//            NavigationManager.shared.setupLanding()
//        } else {
//            NavigationManager.shared.setupSingIn()
//        }
//    }
    
    func switchToLanding(){
        let vc = LandingVC.instantiate(fromAppStoryboard: .Landing)
        let nav = UINavigationController(rootViewController: vc)
        nav.isNavigationBarHidden = true
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
    }
    
    //------------------------------------------------------
    
    //MARK: UIApplicationDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configureKeboard()
        
        return true
    }
}

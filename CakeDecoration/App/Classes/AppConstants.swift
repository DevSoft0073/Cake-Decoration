//
//  AppConstants.swift
//  Nodat
//
//  Created by apple on 30/09/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit


let kAppName : String = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? "Cake Decoration"
let kAppBundleIdentifier : String = Bundle.main.bundleIdentifier ?? String()

class KeyMessages{
    static let shared = KeyMessages()
    let kNoInternet = "There is no internet connection."
    let kEnterName = "Please enter username."
    let kValidUserName = "Username may only have alpha numeric characters and the special characters (.) (-) (_) and may not begin with special characters."
    let kEnterPhone = "Please enter phone number."
    let kEnterValidPhone = "Invalid Phone Number. Please enter a valid phone number."
    let kEnterFirstname = "Please enter first name."
    let kEnterLastname = "Please enter last name."
    let kEnterEmailPwd = "Please enter email and password."
    let kEnterEmail = "Please enter email address."
    let kEnterValidEmail = "Invalid email, Please try again."
    let kEnterConfirmEmail = "Please enter confirm email."
    let kEnterConfirmValidEmail = "Confirm email must match."
    let kEnterPassword = "Please enter password."
    let kEnterConfirmPassword = "Please enter confirm password."
    let kPasswordNotMatch = "Passwords does not matched."
    let kPasswordWeak = "Password must be atleast 6 characters in length. It can be changed later."
    let kEnterZip = "Please enter zip code."
    let kEnterValidZip = "Invalid zipcode. Please enter a correct 5 digit zipcode."
    let kLogout = "Are you sure you want to log out?"
    let kAcceptTerms = "Please read Terms & Conditions and accept for register new account."
}


struct NDFont {
    
    static let defaultRegularFontSize: CGFloat = 20.0
    static let zero: CGFloat = 0.0
    static let reduceSize: CGFloat = 3.0
    static let increaseSize : CGFloat = 2.0
    
    //"family: SF Pro Display"
    static func robotoRegular(size: CGFloat?) -> UIFont {
        return UIFont(name: "Roboto-Regular", size: size ?? defaultRegularFontSize)!
    }
    static func robotoBold(size: CGFloat?) -> UIFont {
        return UIFont(name: "Roboto-Bold", size: size ?? defaultRegularFontSize)!
    }
}


struct NDColor {
    static let appBlue = UIColor(named: "AppBlue")
    static let textFieldBorder = UIColor(named: "textFieldBorder")
    static let textFieldPlaceholder = UIColor(named: "placeHolderColor")
    static let errorColor = #colorLiteral(red: 0.7907256484, green: 0.234187305, blue: 0.2413808405, alpha: 1)
    static let linkColor = #colorLiteral(red: 0.2, green: 0.5725490196, blue: 0.8666666667, alpha: 1)
    static let white = UIColor.white
    static let black = UIColor.black
    static let darkGray = UIColor.darkGray
    static let clear = UIColor.clear
    static let red = #colorLiteral(red: 0.9825670123, green: 0.2279840708, blue: 0.1802871227, alpha: 1)
}

struct DefaultKeys{
    static let introShown = "introShown"
    static let deviceToken = "deviceToken"
    static let token = "AuthToken"
    static let expireValue = "TokenExpire"
    static let id = "userId"
    static let radius = "radius"
    static let savedLat = "savedLat"
    static let savedLong = "savedLong"
    static let savedCity = "savedCity"
    static let saveCityWithOutState = "saveCityWithOutState"
    static let showCategory = "showCategory"
    static let isGuestLogin = "guestLogin"
}

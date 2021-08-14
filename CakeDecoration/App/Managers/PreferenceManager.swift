//
//  PreferenceManager.swift
//  NewProject
//
//  Created by Dharmesh Avaiya on 22/08/20.
//  Copyright © 2020 dharmesh. All rights reserved.
//

import UIKit
import AssistantKit

class PreferenceManager: NSObject {

    public static var shared = PreferenceManager()
    private let userDefault = UserDefaults.standard
       
    //------------------------------------------------------
    
    //MARK: Settings
    
    var userBaseURL: String {
        return "http://18.217.235.67/CakeDecoration/"
        
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    private let keyDeviceToken = "deviceToken"
    private let keyUserId = "userId"
    private let userType = "userType"
    private let keyUserData = "keyUserData"

    var deviceToken: String? {
        set {
            if newValue != nil {
                userDefault.set(newValue!, forKey: keyDeviceToken)
            } else {
                userDefault.removeObject(forKey: keyDeviceToken)
            }
            userDefault.synchronize()
        }
        get {
            let token = userDefault.string(forKey: keyDeviceToken)
            if token?.isEmpty == true || token == nil {
                return Device.versionCode
            } else {
                return userDefault.string(forKey: keyDeviceToken)
            }            
        }
    }
    
    var currentUser: String? {
        set {
            if newValue != nil {
                userDefault.set(newValue!, forKey: keyUserData)
            } else {
                userDefault.removeObject(forKey: keyUserData)
            }
            userDefault.synchronize()
        }
        get {
            return userDefault.string(forKey: keyUserData)
        }
    }
    
    var currentUserModal: UserModal? {
        if let currentUser = currentUser {
            do {
                return try UserModal(currentUser)
            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }
        return nil
    }

    var userId: String? {
        set {
            if newValue != nil {
                userDefault.set(newValue!, forKey: keyUserId)
            } else {
                userDefault.removeObject(forKey: keyUserId)
            }
            userDefault.synchronize()
        }
        get {            
            return userDefault.string(forKey: keyUserId)
        }
    }
    
    var curretMode: String? {
        set {
            if newValue != nil {
                userDefault.set(newValue!, forKey: userType)
            } else {
                userDefault.removeObject(forKey: userType)
            }
            userDefault.synchronize()
        }
        get {
            return userDefault.string(forKey: userType)
        }
    }
    
    //------------------------------------------------------
}

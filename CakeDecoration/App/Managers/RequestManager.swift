//
//  RequestManager.swift
//  NewProject
//
//  Created by Dharmesh Avaiya on 22/08/20.
//  Copyright © 2020 dharmesh. All rights reserved.
//

import UIKit
import Alamofire

struct Request {
    
    struct Parameter {
        
        static let id = "id"
        static let firstName = "firstname"
        static let lastName = "lastname"
        static let email = "email"
        static let password = "password"
        static let deviceToken = "device_token"
        static let deviceType = "device_type" //ios/android
        static let name = "name"
        static let employeeId = "employee_id"
        static let status = "status"
        static let month = "month"
        static let week = "week"
        static let avgVal = "avg_retailer_value"
        static let inventoryDate = "inventory_date"
        static let item_name = "item_name"
        static let display_case = "display_case"
        static let walk_in = "walk_in"
        static let other_storage = "other_storage"
        static let total_H = "total_H"
        static let price = "price"
        static let purchased = "purchased"
        static let sold = "sold"
        static let actual_total = "actual_total"
        static let variance = "variance"
        static let item_detail = "item_detail"
        static let orderStatu = "order_ready_status"
        static let order_id = "order_id"
    }
    
    struct Method {
    
        static let login = "Login.php"
        static let orderListing = "OrderListing.php"
        static let addDailyInventory = "DailyInventorySubmit.php"
        static let allEmployees = "GetAllEmployeedetail.php"
        static let readyStatus = "OrderReadyStatus.php"
    }    
}

class RequestManager: NSObject {
    
    static var shared = RequestManager()
    
    fileprivate var isReachable: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    public var isSessionExpired: Bool = false
    
    //------------------------------------------------------
    
    //MARK: Background Task
    
    var backgroundTask = UIBackgroundTaskIdentifier.invalid
   
    fileprivate func backgroundFetch(_ requestMethod: String) {
        let app = UIApplication.shared
        let endBackgroundTask = {
            if self.backgroundTask != UIBackgroundTaskIdentifier.invalid {
                app.endBackgroundTask(self.backgroundTask)
                self.backgroundTask = UIBackgroundTaskIdentifier.invalid
            }
        }
        backgroundTask = app.beginBackgroundTask(withName: String(format: "%@.%@", kAppBundleIdentifier, requestMethod)) {
            endBackgroundTask()
        }
    }
    
    //------------------------------------------------------
    
    //MARK: GENERAL       
    
    fileprivate func requestREST<T: Decodable>(type: HTTPMethod, requestMethod : String, parameter : [String : Any], showLoader : Bool, decodingType: T.Type, successBlock:@escaping ((_ response: T)->Void), failureBlock:@escaping ((_ error : ErrorModal) -> Void)) {
        
        guard isReachable == true else {
            LoadingManager.shared.hideLoading()
            delay {
                LoadingManager.shared.showError(message: "LocalizableConstants.Error.noNetworkConnection")
            }
            return
        }
          
        var requestURL: String = String()
        var headers: HTTPHeaders = [:]
        headers["content-type"] = "application/json"
        /*if type == .post {
            headers["content-type"] = "application/x-www-form-urlencoded"
        }*/
        requestURL = PreferenceManager.shared.userBaseURL.appending(requestMethod)
        
        debugPrint("----------- \(requestMethod) ---------")
        debugPrint("requestURL:\(requestURL)")
        debugPrint("requestHeader:\(headers)")
        print("parameter:\(parameter.dict2json())")
        
        if showLoader == true {
            LoadingManager.shared.showLoading()
        }
        
        backgroundFetch(requestMethod)
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        
        let encodingType: ParameterEncoding = (type == HTTPMethod.post) ? JSONEncoding.default : URLEncoding.default
        request(requestURL, method: type, parameters: parameter, encoding: encodingType, headers: headers).responseData { (response: DataResponse<Data>) in
            switch response.result {
            case .success:
                if showLoader == true {
                    LoadingManager.shared.hideLoading()
                }
                if let jsonData = response.result.value {
                    do {
                        let responseString = try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
                        print(".success:\(String(describing: responseString?.dict2json()))")
                        debugPrint("--------------------")
                        if response.response?.statusCode == Status.Code.success {
                            if jsonData.count > 0 {
                                let result = try JSONDecoder().decode(decodingType, from: jsonData)
                                successBlock(result)
                            } else {
                                let emptyData = try JSONSerialization.data(withJSONObject: [:], options: [])
                                let result = try JSONDecoder().decode(decodingType, from: emptyData)
                                successBlock(result)
                            }
                        } else {
                            let emptyData = try JSONSerialization.data(withJSONObject: [:], options: [])
                            let result = try JSONDecoder().decode(decodingType, from: emptyData)
                            successBlock(result)
                        }
                    } catch let error {
                        debugPrint(".failure:\(error.localizedDescription)")
                        debugPrint("--------------------")
                        let errorModal = ErrorModal(code: error._code, errorDescription: error.localizedDescription)
                        failureBlock(errorModal)
                    }
                }
                break
            case .failure(let error):
                
                if showLoader == true {
                    LoadingManager.shared.hideLoading()
                }
                debugPrint(".failure:\(error.localizedDescription)")
                debugPrint("--------------------")
                let errorModal = ErrorModal(code: error._code, errorDescription: error.localizedDescription)
                failureBlock(errorModal)
                break
            }
        }
    }
    
    
    fileprivate func requestRESTT<T: Decodable>(type: HTTPMethod, requestMethod : String, showLoader : Bool, decodingType: T.Type, successBlock:@escaping ((_ response: T)->Void), failureBlock:@escaping ((_ error : ErrorModal) -> Void)) {
        
        guard isReachable == true else {
            LoadingManager.shared.hideLoading()
            delay {
                LoadingManager.shared.showError(message: "LocalizableConstants.Error.noNetworkConnection")
            }
            return
        }
          
        var requestURL: String = String()
        var headers: HTTPHeaders = [:]
        headers["content-type"] = "application/json"
        /*if type == .post {
            headers["content-type"] = "application/x-www-form-urlencoded"
        }*/
        requestURL = PreferenceManager.shared.userBaseURL.appending(requestMethod)
        
        debugPrint("----------- \(requestMethod) ---------")
        debugPrint("requestURL:\(requestURL)")
        debugPrint("requestHeader:\(headers)")
        
        if showLoader == true {
            LoadingManager.shared.showLoading()
        }
        
        backgroundFetch(requestMethod)
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        
        let encodingType: ParameterEncoding = (type == HTTPMethod.post) ? JSONEncoding.default : URLEncoding.default
        request(requestURL, method: type, encoding: encodingType, headers: headers).responseData { (response: DataResponse<Data>) in
            switch response.result {
            case .success:
                if showLoader == true {
                    LoadingManager.shared.hideLoading()
                }
                if let jsonData = response.result.value {
                    do {
                        let responseString = try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
                        print(".success:\(String(describing: responseString?.dict2json()))")
                        debugPrint("--------------------")
                        if response.response?.statusCode == Status.Code.success {
                            if jsonData.count > 0 {
                                let result = try JSONDecoder().decode(decodingType, from: jsonData)
                                successBlock(result)
                            } else {
                                let emptyData = try JSONSerialization.data(withJSONObject: [:], options: [])
                                let result = try JSONDecoder().decode(decodingType, from: emptyData)
                                successBlock(result)
                            }
                        } else {
                            let emptyData = try JSONSerialization.data(withJSONObject: [:], options: [])
                            let result = try JSONDecoder().decode(decodingType, from: emptyData)
                            successBlock(result)
                        }
                    } catch let error {
                        debugPrint(".failure:\(error.localizedDescription)")
                        debugPrint("--------------------")
                        let errorModal = ErrorModal(code: error._code, errorDescription: error.localizedDescription)
                        failureBlock(errorModal)
                    }
                }
                break
            case .failure(let error):
                
                if showLoader == true {
                    LoadingManager.shared.hideLoading()
                }
                debugPrint(".failure:\(error.localizedDescription)")
                debugPrint("--------------------")
                let errorModal = ErrorModal(code: error._code, errorDescription: error.localizedDescription)
                failureBlock(errorModal)
                break
            }
        }
    }

    
    //------------------------------------------------------
    
    //MARK: GET
    
    func requestGET<T: Decodable>(requestMethod : String, parameter : [String : Any], showLoader : Bool, decodingType: T.Type, successBlock:@escaping ((_ response: T)->Void), failureBlock:@escaping ((_ error : ErrorModal) -> Void)) {
        
        requestREST(type: HTTPMethod.get, requestMethod: requestMethod, parameter: parameter, showLoader: showLoader, decodingType: decodingType, successBlock: { (response: T) in
            
            successBlock(response)
            
        }, failureBlock: { (error: ErrorModal) in
            
            failureBlock(error)
        })
    }
    
    //------------------------------------------------------
    
    //MARK: POST
   
    func requestPOST<T: Decodable>(requestMethod : String, parameter : [String : Any], headers : [String : String]? = nil, showLoader : Bool, decodingType: T.Type, successBlock:@escaping ((_ response: T)->Void), failureBlock:@escaping ((_ error : ErrorModal) -> Void)) {
        
        requestREST(type: HTTPMethod.post, requestMethod: requestMethod, parameter: parameter, showLoader: showLoader, decodingType: decodingType, successBlock: { (response: T) in
            
            successBlock(response)
            
        }, failureBlock: { (error: ErrorModal) in
            
            failureBlock(error)
        })
    }
    
    
    func requestPOSTT<T: Decodable>(requestMethod : String, headers : [String : String]? = nil, showLoader : Bool, decodingType: T.Type, successBlock:@escaping ((_ response: T)->Void), failureBlock:@escaping ((_ error : ErrorModal) -> Void)) {
        
        requestRESTT(type: HTTPMethod.post, requestMethod: requestMethod , showLoader: showLoader, decodingType: decodingType, successBlock: { (response: T) in
            
            successBlock(response)
            
        }, failureBlock: { (error: ErrorModal) in
            
            failureBlock(error)
        })
    }
    
    //------------------------------------------------------
}

struct Status {
    
    struct Code {
        
        static let emailNotVerified = 108
        static let success = 200
        static let unauthorized = 401
        static let notfound = 404
        static let sessionExpired = 500
    }
}


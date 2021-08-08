//
//  HomeDetails.swift
//  BRInventory
//
//  Created by Phani's MacBook Pro on 03/08/21.
//

import Foundation


struct HomeDetails {
    var name: String
    var image: String
    var description: String
}


struct HomeMenu{
    var type: MenuType
    var name: String
    var image: String
    enum MenuType{
        case user
        case employee
    }
}


struct EmployeeManagement {
    var name: String
    var image: String
    var description: String
}


struct EmployeeMenu{
    var type: MenuType
    var name: String
    var image: String
    enum MenuType{
        case cakeEnventory
        case reports
    }
}

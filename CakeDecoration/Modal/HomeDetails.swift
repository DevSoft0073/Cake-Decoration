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


struct InventoryDetails {
    var name: String
    var image: String
    var description: String
}


struct InventoryDetailsItems{
    var type: InventoryMenuType
    var name: String
    var image: String
    enum InventoryMenuType{
        case add
        case cakeList
        case inventory
    }
}

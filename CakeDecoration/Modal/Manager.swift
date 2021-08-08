//
//  Manager.swift
//  BRInventory
//
//  Created by Phani's MacBook Pro on 05/08/21.
//

import Foundation


struct ManagerOptions {
    var name: String
    var image: String
    var type: ManagementType
    enum ManagementType{
        case catCostSummary
        case costManagement
        case wasteManagement
        case invManagement
        case reOrderManagement
    }
}

//
//  OnHand.swift
//  CakeDecoration
//
//  Created by MyMac on 8/22/21.
//

import Foundation

// MARK: - OnHandItems
struct OnHandItems: Codable , Hashable {
    var id, inventoryID, employeeID, itemID: String?
    var itemName, displayCase, walkIn, otherStorage: String?
    var total, lastInventoryCount, lastInventoryDate, delta: String?
    var avgRetailerValue, missedValue, inventoryDate, creationAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case inventoryID = "inventory_id"
        case employeeID = "employee_id"
        case itemID = "item_id"
        case itemName = "item_name"
        case displayCase = "display_case"
        case walkIn = "walk_in"
        case otherStorage = "other_storage"
        case total
        case lastInventoryCount = "last_inventory_count"
        case lastInventoryDate = "last_inventory_date"
        case delta
        case avgRetailerValue = "avg_retailer_value"
        case missedValue = "missed_value"
        case inventoryDate = "inventory_date"
        case creationAt = "creation_at"
    }
}

// MARK: OnHandItems convenience initializers and mutators

extension OnHandItems {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(OnHandItems.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

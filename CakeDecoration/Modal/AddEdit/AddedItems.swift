//
//  AddedItems.swift
//  CakeDecoration
//
//  Created by MyMac on 8/22/21.
//

import Foundation

// MARK: - ShowItems
struct ShowItems: Codable , Hashable{
    var itemID, itemName, employeeID, creationAt: String?
    var lastInventoryCount: String?
    var lastInventoryDate: String?

    enum CodingKeys: String, CodingKey {
        case itemID = "item_id"
        case itemName = "item_name"
        case employeeID = "employee_id"
        case creationAt = "creation_at"
        case lastInventoryCount = "last_inventory_count"
        case lastInventoryDate = "last_inventory_date"
    }
}

// MARK: ShowItems convenience initializers and mutators

extension ShowItems {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ShowItems.self, from: data)
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

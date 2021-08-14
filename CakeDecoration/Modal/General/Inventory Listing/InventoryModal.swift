//
//  InventoryModal.swift
//  CakeDecoration
//
//  Created by MyMac on 14/08/21.
//

import Foundation

// MARK: - InventoryModal
struct InventoryModal: Codable {
    var inventoryID, employeeID, inventoryDate, created: String?
    var disabled: String?

    enum CodingKeys: String, CodingKey {
        case inventoryID = "inventory_id"
        case employeeID = "employee_id"
        case inventoryDate = "inventory_date"
        case created, disabled
    }
}

// MARK: InventoryModal convenience initializers and mutators

extension InventoryModal {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(InventoryModal.self, from: data)
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

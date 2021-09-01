//
//  AddEDIT.swift
//  CakeDecoration
//
//  Created by MyMac on 8/21/21.
//

import Foundation

// MARK: - AddEditModal
struct AddEditModal: Codable {
    var itemID, itemName, employeeID, creationAt: String?

    enum CodingKeys: String, CodingKey {
        case itemID = "item_id"
        case itemName = "item_name"
        case employeeID = "employee_id"
        case creationAt = "creation_at"
    }
}

// MARK: AddEditModal convenience initializers and mutators

extension AddEditModal {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(AddEditModal.self, from: data)
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

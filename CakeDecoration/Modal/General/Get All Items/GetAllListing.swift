//
//  GetAllListing.swift
//  CakeDecoration
//
//  Created by MyMac on 13/08/21.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let getAllListing = try GetAllListing(json)

import Foundation

// MARK: - GetAllListing
struct GetAllListing: Codable , Hashable{
    var itemID, userID, catID, name: String?
    var getAllListingDescription, price, quantity, created: String?
    var updated: String?

    enum CodingKeys: String, CodingKey {
        case itemID = "itemId"
        case userID = "userId"
        case catID = "catId"
        case name
        case getAllListingDescription = "description"
        case price, quantity, created, updated
    }
}

// MARK: GetAllListing convenience initializers and mutators

extension GetAllListing {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(GetAllListing.self, from: data)
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


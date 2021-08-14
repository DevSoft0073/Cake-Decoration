//
//  AddOrder.swift
//  CakeDecoration
//
//  Created by MyMac on 13/08/21.

import Foundation

// MARK: - AddOrder
struct AddOrder: Codable {
    var employeeID, orderedDate, orderTime, orderDay: String?
    var name, phoneDay, phoneEvening, orderSurprise: String?
    var orderPick, totalGuest, iceCreamFlavour, cakeFlavour: String?
    var crust, rollCakeFlavour, ageGroup, cakeName: String?
    var frostingColor, message, birthday, congratulation: String?
    var anniversary, cakePrice, photoCakePrice, specialDesignPrice: String?
    var candles, totalCost, depositPaid, balance: String?
    var expectedOrderReady, photo, email: String?

    enum CodingKeys: String, CodingKey {
        case employeeID = "employee_id"
        case orderedDate = "ordered_date"
        case orderTime = "order_time"
        case orderDay = "order_day"
        case name
        case phoneDay = "phone_day"
        case phoneEvening = "phone_evening"
        case orderSurprise = "order_surprise"
        case orderPick = "order_pick"
        case totalGuest = "total_guest"
        case iceCreamFlavour = "ice_cream_flavour"
        case cakeFlavour = "cake_flavour"
        case crust
        case rollCakeFlavour = "roll_cake_flavour"
        case ageGroup = "age_group"
        case cakeName = "cake_name"
        case frostingColor = "frosting_color"
        case message, birthday, congratulation, anniversary
        case cakePrice = "cake_price"
        case photoCakePrice = "photo_cake_price"
        case specialDesignPrice = "special_design_price"
        case candles
        case totalCost = "total_cost"
        case depositPaid = "deposit_paid"
        case balance
        case expectedOrderReady = "expected_order_ready"
        case photo, email
    }
}

// MARK: AddOrder convenience initializers and mutators

extension AddOrder {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(AddOrder.self, from: data)
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

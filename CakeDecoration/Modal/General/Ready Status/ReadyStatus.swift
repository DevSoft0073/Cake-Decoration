//
//  ReadyStatus.swift
//  CakeDecoration
//
//  Created by MyMac on 11/08/21.
//

import Foundation

// MARK: - ReadyStatus
struct ReadyStatus: Codable {
    var id, userID, orderID, employeeID: String?
    var orderedDate, orderDateStr, expectedOrderReady, orderTime: String?
    var orderDay, name, phoneDay, phoneEvening: String?
    var orderSurprise, orderPick, totalGuest, iceCreamFlavour: String?
    var cakeFlavour, crust, rollCakeFlavour, ageGroup: String?
    var cakeName, frostingColor: String?
    var photo: String?
    var message, birthday, congratulation, anniversary: String?
    var cakePrice, photoCakePrice, specialDesignPrice, candles: String?
    var totalCost, depositPaid, balance, orderReadyStatus: String?
    var paidStatus, creationAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case orderID = "order_id"
        case employeeID = "employee_id"
        case orderedDate = "ordered_date"
        case orderDateStr = "order_date_str"
        case expectedOrderReady = "expected_order_ready"
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
        case photo, message, birthday, congratulation, anniversary
        case cakePrice = "cake_price"
        case photoCakePrice = "photo_cake_price"
        case specialDesignPrice = "special_design_price"
        case candles
        case totalCost = "total_cost"
        case depositPaid = "deposit_paid"
        case balance
        case orderReadyStatus = "order_ready_status"
        case paidStatus = "paid_status"
        case creationAt = "creation_at"
    }
}

// MARK: ReadyStatus convenience initializers and mutators

extension ReadyStatus {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ReadyStatus.self, from: data)
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

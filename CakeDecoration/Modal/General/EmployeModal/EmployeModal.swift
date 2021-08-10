//
//  EmployeModal.swift
//  CakeDecoration
//
//  Created by MyMac on 11/08/21.
//

import Foundation

// MARK: - EmployeeModal
struct EmployeeModal: Codable {
    var id, name, email, password: String?
    var image, authenticateToken, role, loginStatus: String?
    var creationAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, email, password, image
        case authenticateToken = "authenticate_token"
        case role
        case loginStatus = "login_status"
        case creationAt = "creation_at"
    }
}

// MARK: EmployeeModal convenience initializers and mutators

extension EmployeeModal {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(EmployeeModal.self, from: data)
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

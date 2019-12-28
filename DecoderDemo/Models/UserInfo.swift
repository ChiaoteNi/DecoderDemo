//
//  UserInfo.swift
//  DecoderDemo
//
//  Created by Aaron_Ni on 2019/11/18.
//  Copyright © 2019 Aaron_Ni. All rights reserved.
//

import Foundation

struct UserInfo: Decodable {
    
    var userID: String
    var gender: Gender
    var age: Int
    var height: Int
    var weight: Int
    
    enum InfoKeys: String, CodingKey {
        case userID = "user_id"
        case gender, age, height, weight
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: InfoKeys.self)
        userID  = try container.decode(String.self, forKey: .userID)
        gender  = try container.decodeIfPresent(Gender.self, forKey: .gender) ?? .man
        age     = try container.decodeIfPresent(Int.self, forKey: .age) ?? 1
        height  = try container.decodeToInt(for: .height)
        weight  = try container.decodeIfPresent(Int.self, forKey: .weight) ?? 0
    }
}

enum Gender: Decodable {
    case man
    case woman
    
    init(from decoder: Decoder) throws {
        let container   = try decoder.singleValueContainer()
        let value       = try container.decode(Int.self)
        
        self = value == 1 ? .man : .woman
    }
}

extension KeyedDecodingContainer {
    
    func decodeToInt(for key: Key) throws -> Int {
        if let value = try? decode(IntegerLiteralType.self, forKey: key) {
            return value
        } else if let value = try? decode(FloatLiteralType.self, forKey: key) {
            return Int(value)
        } else if let text = try? decode(String.self, forKey: key), let value = Int(text) {
            return value
        } else {
            let context: DecodingError.Context = .init(codingPath: codingPath,
                                                       debugDescription: "Wrong type for value")
            throw DecodingError.typeMismatch(Bool.self, context)
        }
    }
}

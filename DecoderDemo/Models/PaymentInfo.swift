//
//  PaymentInfo.swift
//  DecoderDemo
//
//  Created by Aaron_Ni on 2019/11/18.
//  Copyright © 2019 Aaron_Ni. All rights reserved.
//

import Foundation

struct PaymentInfo: Decodable {
    
    var id: String
    var type: InfoType
    var uid: String
    var ownerName: String
    var createTime: Date
    var price: Int
    var productName: String?
    
    enum MainCodingKeys: String, CodingKey {
        case id, type, paymentInfo
        case productName = "product_name"
    }
    
    enum PaymentCodingKeys: String, CodingKey {
        case createTime = "create_time"
        case price = "price"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MainCodingKeys.self)
        
        id      = try container.decode(String.self, forKey: .id)
        type    = try container.decode(InfoType.self, forKey: .type)
        productName = try container.decode(String.self, forKey: .productName)//.decodeIfPresent(String.self, forKey: .productName)
        
        uid = ""
        ownerName = ""
        createTime = .init(timeIntervalSince1970: 0)
        price = 0
        
        
        var ownerInfo = try container.nestedUnkeyedContainer(forKey: .paymentInfo)
        
        while ownerInfo.isAtEnd == false {
            switch ownerInfo.currentIndex {
            case 0:
                uid = try ownerInfo.decode(String.self)
            case 1:
                ownerName = try ownerInfo.decode(String.self)
            case 2:
                let paymentContainer = try ownerInfo.nestedContainer(keyedBy: PaymentCodingKeys.self)
                createTime  = try paymentContainer.decode(Date.self, forKey: .createTime)
                price       = try paymentContainer.decode(Int.self, forKey: .price)
            default: break
            }
        }
    }
}

enum InfoType: String, Decodable {
    case payment = "payment"
    case another = "another"
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        switch value {
        case "payment":
            self = .payment
        case "another":
            self = .another
        default:
            self = .another
        }
    }
}

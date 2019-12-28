//
//  PlaceInfo.swift
//  DecoderDemo
//
//  Created by Aaron_Ni on 2019/11/17.
//  Copyright © 2019 Aaron_Ni. All rights reserved.
//

import Foundation

struct PlaceInfo: Decodable {
    var name: String
    var address: String
    var phoneNumber: String
    
    // Without custom init from decoder
    enum CodingKeys: String, CodingKey {
        case name
        case address = "formatted_address"
        case phoneNumber = "international_phone_number"
    }
    
//    // With custom init from decoder
//        enum PlaceInfoKeys: String, CodingKey {
//            case name = "name"
//            case address = "formatted_address"
//            case phoneNumber = "international_phone_number"
//        }
//
//        init(from decoder: Decoder) throws {
//
//
//    print(decoder)
//
//            let container = try decoder.container(keyedBy: PlaceInfoKeys.self)
//            name = try container.decode(String.self, forKey: .name)
//            address = try container.decode(String.self, forKey: .address)
//            phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
//        }
}

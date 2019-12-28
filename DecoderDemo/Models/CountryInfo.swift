//
//  CountryInfo.swift
//  DecoderDemo
//
//  Created by Aaron_Ni on 2019/11/18.
//  Copyright © 2019 Aaron_Ni. All rights reserved.
//

import Foundation

struct CountryInfo: Decodable {
    var continentalName: String
    var countries: [String]
}

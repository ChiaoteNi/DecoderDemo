//
//  PlaceNestInfo.swift
//  DecoderDemo
//
//  Created by Aaron_Ni on 2019/11/17.
//  Copyright © 2019 Aaron_Ni. All rights reserved.
//

import Foundation
import CoreLocation

struct PlaceNestInfo: Decodable {
    
    var name: String
    var location: CLLocationCoordinate2D
    var openingTime: [String]
    
    enum PlaceInfoKeys: String, CodingKey {
        case name
        case geometry
        case openingTime = "opening_hours"
    }
    
    enum OpeningTimeKeys: String, CodingKey {
        case weekdayText = "weekday_text"
    }
    
    enum GeometryKeys: String, CodingKey {
        case location
    }
    
    enum Coordinate: String, CodingKey {
        case lat
        case lng
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PlaceInfoKeys.self)
        // Decode to name.
        name = try container.decode(String.self, forKey: .name)
        
        // Decode to location.
        let geometry = try container.nestedContainer(keyedBy: GeometryKeys.self, forKey: .geometry)
        let coordinate = try geometry.nestedContainer(keyedBy: Coordinate.self, forKey: .location)
        
        print("⛺️", geometry.codingPath)
        print("🐤", geometry.allKeys)
        print("🐛", coordinate.codingPath)
        print("🦈", coordinate.allKeys)
        
        let lat = try coordinate.decode(Double.self, forKey: .lat)
        let lng = try coordinate.decode(Double.self, forKey: .lng)
        location = .init(latitude: lat, longitude: lng)
        
        // Decode to opening time.
        let openingInfos = try container.nestedContainer(keyedBy: OpeningTimeKeys.self, forKey: .openingTime)
        var arrayContainer = try openingInfos.nestedUnkeyedContainer(forKey: .weekdayText)
        
        openingTime = []
        while arrayContainer.isAtEnd == false {
            guard let text = try? arrayContainer.decode(String.self) else { continue }
            openingTime.append(text)
        }
    }
}

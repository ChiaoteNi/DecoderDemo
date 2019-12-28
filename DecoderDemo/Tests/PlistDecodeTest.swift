//
//  PlistDecodeTest.swift
//  DecoderTest
//
//  Created by Aaron_Ni on 2019/11/18.
//  Copyright © 2019 Aaron_Ni. All rights reserved.
//

import XCTest

class PlistDecodeTest: XCTestCase {

    var data: Data?
    var decoder: PropertyListDecoder = .init()
    
    override func setUp() {
        decoder = .init()
        
        guard let url = Bundle.init(for: type(of: self))
            .url(forResource: "CountryInfo", withExtension: "plist") else {
                return assert(false, "Data not found.")
        }
        
        do {
            data = try .init(contentsOf: url, options: .alwaysMapped)
        } catch {
            assert(false, "\(error.localizedDescription)")
        }
    }
    
    override func tearDown() {
        data = nil
    }
    
    func testDecode() {
        guard let data = data else {
            return XCTAssert(false, "Data not found.")
        }
        if let models = try? decoder.decode([CountryInfo].self, from: data) {
            guard let model = models.first else {
                return XCTAssert(false, "\(models)")
            }
            print(model)
            
            XCTAssert(model.continentalName == "亞洲", "\(model.continentalName)")
            XCTAssert(model.countries[1] == "日本", "\(model.countries[1])")
        } else {
            XCTAssert(false, "Model decode fail.")
        }
    }
}

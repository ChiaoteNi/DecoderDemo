//
//  CodingKeyTest.swift
//  DecoderDemo
//
//  Created by Aaron_Ni on 2019/11/18.
//  Copyright © 2019 Aaron_Ni. All rights reserved.
//

import XCTest


class CodingKeyTest: XCTestCase {
    
    var data: Data?
    var decoder: JSONDecoder = .init()

    override func setUp() {
        decoder = .init()
        
        guard let url = Bundle.init(for: type(of: self))
            .url(forResource: "SnakeFormatKey", withExtension: "json") else {
            return assert(false, "SnakeFormatKey not found.")
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
            return XCTAssert(false, "SnakeFormatKey not found.")
        }
        if let model = try? decoder.decode(PlaceInfo.self, from: data) {
            XCTAssert(model.address == "48 Pirrama Rd, Sydney NSW 2009, Australia", "\(model)")
        } else {
            XCTAssert(false, "Model decode fail.")
        }
    }
}

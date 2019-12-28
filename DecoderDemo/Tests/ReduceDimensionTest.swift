//
//  ReduceDimensionTest.swift
//  DecoderTest
//
//  Created by Aaron_Ni on 2019/11/18.
//  Copyright © 2019 Aaron_Ni. All rights reserved.
//

import XCTest

class ReduceDimensionTest: XCTestCase {

    var data: Data?
    var decoder: JSONDecoder = .init()
    
    override func setUp() {
        decoder = .init()
        
        guard let url = Bundle.init(for: type(of: self))
            .url(forResource: "Nested", withExtension: "json") else {
            return assert(false, "Nested not found.")
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
            return XCTAssert(false, "Nested not found.")
        }
        if let model = try? decoder.decode(PlaceNestInfo.self, from: data) {
            print(model)
            XCTAssert(model.location.latitude == -33.8666199)
        } else {
            XCTAssert(false, "Model decode fail.")
        }
    }
}

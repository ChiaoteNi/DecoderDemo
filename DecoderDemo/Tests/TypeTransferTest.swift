//
//  TypeTransferTest.swift
//  DecoderTest
//
//  Created by Aaron_Ni on 2019/11/18.
//  Copyright © 2019 Aaron_Ni. All rights reserved.
//

import XCTest

class TypeTransferTest: XCTestCase {

    var data: Data?
    var decoder: JSONDecoder = .init()
    
    override func setUp() {
        decoder = .init()
        
        guard let url = Bundle.init(for: type(of: self))
            .url(forResource: "TypeTransfer", withExtension: "json") else {
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
        if let model = try? decoder.decode(UserInfo.self, from: data) {
            print(model)
            XCTAssert(model.gender == .man)
            XCTAssert(model.age == 18)
            XCTAssert(model.height == 176)
        } else {
            XCTAssert(false, "Model decode fail.")
        }
    }
}

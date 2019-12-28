//
//  NestedUnkeyedContainerTest.swift
//  DecoderTest
//
//  Created by Aaron_Ni on 2019/11/18.
//  Copyright © 2019 Aaron_Ni. All rights reserved.
//

import XCTest

class NestedUnkeyedContainerTest: XCTestCase {

    var data: Data?
    var decoder: JSONDecoder = .init()
    
    override func setUp() {
        decoder = .init()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        guard let url = Bundle.init(for: type(of: self))
            .url(forResource: "MutiTypeElementArray", withExtension: "json") else {
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
        if let model = try? decoder.decode(PaymentInfo.self, from: data) {
            print(model)
            XCTAssert(model.type == .payment, "\(model)")
            XCTAssert(model.ownerName == "王小明", "\(model)")
            XCTAssert(model.price == 30000, "\(model)")
            print(model.createTime.timeIntervalSince1970)
            XCTAssert(Int(model.createTime.timeIntervalSince1970) == 1574006400, "\(model)")
        } else {
            XCTAssert(false, "Model decode fail.")
        }
    }
}

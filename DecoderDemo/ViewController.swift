//
//  ViewController.swift
//  DecoderDemo
//
//  Created by Aaron_Ni on 2019/11/16.
//  Copyright © 2019 Aaron_Ni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let decoder = JSONDecoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = Bundle.main.url(forResource: "MutiTypeElementArray", withExtension: "json") else {
            return assert(false, "Data not found.")
        }
        guard let data = try? Data.init(contentsOf: url) else { return }
        do {
            let model = try decoder.decode(PaymentInfo.self, from: data)
            print(model)
        } catch {
            print(error)
        }
    }
}


//
//  Rates.swift
//  Rx Swift Sample
//
//  Created by JETS Mobil Lab -  on 5/27/19.
//  Copyright © 2019 Abd elrhman. All rights reserved.
//

import Foundation

struct Rates: Codable {
    let base: String
    let rates: [String: Double]
    let date: String
}

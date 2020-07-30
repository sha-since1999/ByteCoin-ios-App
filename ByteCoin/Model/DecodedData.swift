//
//  DecodedData.swift
//  ByteCoin
//
//  Created by Rohit sahu on 23/07/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct DecodedData : Codable {
    let time : String
    let asset_id_base : String
    let asset_id_quote : String
    let rate : Double
    
}

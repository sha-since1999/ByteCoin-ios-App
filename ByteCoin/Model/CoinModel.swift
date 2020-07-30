//
//  CoinModel.swift
//  ByteCoin
//

import Foundation

struct CoinModel {

    let rate : Double
    var rateString : String{ return String( format: "%0.3f", rate)}
    
}

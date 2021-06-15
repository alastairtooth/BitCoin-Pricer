//
//  CoinData.swift
//  ByteCoin
//
//  Created by Alastair Tooth on 24/8/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation


struct CoinData: Decodable {
    
    let time: String
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
    
    var rateString: String {
        return String(format: "%.2f", rate)
    }
    
}

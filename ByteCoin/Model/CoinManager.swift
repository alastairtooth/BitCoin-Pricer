//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    
    func didUpdatePrice(_ coinManager: CoinManager, coin: CoinData)
    func didFailWithError(error: Error)

}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "YOUR_API_KEY_HERE"
    var delegate: CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        
        let API = "5EED7224-7D43-47A1-B031-83AA710787F4"
        let webAdd = "https://rest.coinapi.io/v1/exchangerate/BTC/\(currency)?apikey=\(API)"
        performRequest(with: webAdd)
        
    }
    
    func performRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    //print(String(data: safeData, encoding: String.Encoding.utf8)!)
                    if let last = self.parseJSON(safeData) {
                        print(last)
                        self.delegate?.didUpdatePrice(self, coin: last)
                    }
                }
            } //this is the end of the closure statement here
            task.resume()
        }
        
    }
    
    
    func parseJSON(_ data: Data) -> CoinData? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let last = decodedData.rate
            let time = decodedData.time
            let base = decodedData.asset_id_base
            let quote = decodedData.asset_id_quote
            
            
            let lastPrice = CoinData(time: time, asset_id_base: base, asset_id_quote: quote, rate: last)
            
            return lastPrice
            
            
        } catch {
            //self.delegate?.didFailWithError(self, error: error)
            return nil
        }
        
    }
    
    
    
    
}


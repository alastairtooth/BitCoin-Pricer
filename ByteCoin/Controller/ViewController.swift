//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    

    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManager.delegate = self //DO NOT FORGET TO DO THIS. IF YOU DON'T DO IT THE DATA WON'T PASS THROUGH FROM COINMANAGER TO THE VIEWCONTROLLER!
        currencyPicker.dataSource = self //Advises the data source for the UIPickerView is the ViewController
        currencyPicker.delegate = self //Advises that the viewController that the ViewController is delegated as in charge of the UIPickerView
    }
}

    //MARK: - UIPickerView Delegate & Datasource

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
        
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1 //Returns the number of columns in the UIPickerView
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return coinManager.currencyArray.count //returns the amount of rows within each column of the UIPickerView
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return coinManager.currencyArray[row] //Returns the values for each row of the UIPickerView
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            
            let selectedCurrency = coinManager.currencyArray[row] //stores the value of the selected row
            coinManager.getCoinPrice(for: selectedCurrency) //passes the currency stored in currentCoin into the getCoinPrice method.
            
        }
        
    }

//MARK: - CoinManager Delegate

extension ViewController: CoinManagerDelegate {
    
    func didUpdatePrice(_ coinManager: CoinManager, coin: CoinData) {
        
        DispatchQueue.main.async {
            self.bitcoinLabel.text = coin.rateString
            self.currencyLabel.text = coin.asset_id_quote
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

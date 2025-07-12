//
//  DataManager.swift
//  STest
//
//  Created by Anita Stashevskaya on 12.07.2025.
//

import Foundation

final class DataManager {
    static let shared = DataManager()
    
    func loadTransactions() -> [Transaction] {
        guard let path = Bundle.main.path(forResource: "transactions", ofType: "plist"),
              let plistData = NSArray(contentsOfFile: path) as? [[String: Any]] else {
            print("Error loading transactions.plist")
            return []
        }
        
        return plistData.compactMap { dict in
            guard let amountStr = dict["amount"] as? String,
                  let amount = Double(amountStr),
                  let currency = dict["currency"] as? String,
                  let sku = dict["sku"] as? String else {
                return nil
            }
            return Transaction(sku: sku, currency: currency, amount: amount)
        }
    }
    
    func loadRates() -> [Rate] {
        guard let path = Bundle.main.path(forResource: "rates", ofType: "plist"),
              let plistData = NSArray(contentsOfFile: path) as? [[String: Any]] else {
            print("Error loading rates.plist")
            return []
        }
        
        return plistData.compactMap { dict in
            guard let from = dict["from"] as? String,
                  let to = dict["to"] as? String,
                  let rateString = dict["rate"] as? String,
                  let rate = Double(rateString) else {
                print("Error parsing rate: \(dict)")
                return nil
            }
            
            let rateObj = Rate(from: from, to: to, rate: rate)
            print("Loaded rate: \(rateObj)")
            return rateObj
        }
    }
}

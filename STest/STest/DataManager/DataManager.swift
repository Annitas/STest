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
            guard let amount = dict["amount"] as? String,
                  let currency = dict["currency"] as? String,
                  let sku = dict["sku"] as? String else {
                return nil
            }
            return Transaction(sku: sku, currency: currency, amount: amount)
        }
    }
}

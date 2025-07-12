//
//  ProductListViewModel.swift
//  STest
//
//  Created by Anita Stashevskaya on 12.07.2025.
//

final class ProductListViewModel {
    private let transactions: [Transaction]
    
    var products: [String] {
        return Set(transactions.map { $0.sku }).sorted()
    }
    
    init() {
        self.transactions = DataManager.shared.loadTransactions()
    }
    
    func transactionCount(for sku: String) -> Int {
        return transactions.filter { $0.sku == sku }.count
    }
}

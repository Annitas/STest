//
//  ProductListViewModel.swift
//  STest
//
//  Created by Anita Stashevskaya on 12.07.2025.
//

final class ProductListViewModel {
    private let transactions: [Transaction]
    private let converter: CurrencyConverter
    
    var products: [String] {
        return Set(transactions.map { $0.sku }).sorted()
    }
    
    init() {
        self.transactions = DataManager.shared.loadTransactions()
        let rates = DataManager.shared.loadRates()
        self.converter = CurrencyConverter(rates: rates)
    }
    
    func transactionCount(for sku: String) -> Int {
        return transactions.filter { $0.sku == sku }.count
    }
    
    func getTransactionDetails(for sku: String) -> TransactionDetailsViewModel {
        let productTransactions = transactions.filter { $0.sku == sku }
        return TransactionDetailsViewModel(transactions: productTransactions, converter: converter)
    }
}

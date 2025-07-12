//
//  TransactionDetailsViewModel.swift
//  STest
//
//  Created by Anita Stashevskaya on 12.07.2025.
//

final class TransactionDetailsViewModel {
    private let transactions: [Transaction]
    private let converter: CurrencyConverter
    
    var transactionDetails: [(transaction: Transaction, gbpAmount: Double?)] {
        return transactions.map { transaction in
            let gbpAmount = converter.convert(amount: transaction.amount, from: transaction.currency, to: "GBP")
            return (transaction: transaction, gbpAmount: gbpAmount)
        }
    }
    
    var totalGBP: Double {
        return transactionDetails.compactMap { $0.gbpAmount }.reduce(0, +)
    }
    
    init(transactions: [Transaction], converter: CurrencyConverter) {
        self.transactions = transactions
        self.converter = converter
    }
}

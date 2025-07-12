//
//  CurrencyConverter.swift
//  STest
//
//  Created by Anita Stashevskaya on 12.07.2025.
//

final class CurrencyConverter {
    private let rates: [Rate]
    private var rateGraph: [String: [(currency: String, rate: Double)]] = [:]
    
    init(rates: [Rate]) {
        self.rates = rates
        buildRateGraph()
    }
    
    private func buildRateGraph() {
        for rate in rates {
            if rateGraph[rate.from] == nil {
                rateGraph[rate.from] = []
            }
            if rateGraph[rate.to] == nil {
                rateGraph[rate.to] = []
            }
            
            rateGraph[rate.from]?.append((currency: rate.to, rate: rate.rate))
            rateGraph[rate.to]?.append((currency: rate.from, rate: 1.0 / rate.rate))
        }
    }
    
    func convert(amount: Double, from: String, to: String) -> Double? {
        if from == to {
            return amount
        }
        
        guard let conversionRate = findConversionRate(from: from, to: to) else {
            return nil
        }
        
        return amount * conversionRate
    }
    
    private func findConversionRate(from: String, to: String) -> Double? {
        var visited: Set<String> = []
        var queue: [(currency: String, rate: Double)] = [(currency: from, rate: 1.0)]
        
        while !queue.isEmpty {
            let current = queue.removeFirst()
            
            if current.currency == to {
                return current.rate
            }
            
            if visited.contains(current.currency) {
                continue
            }
            
            visited.insert(current.currency)
            
            if let neighbors = rateGraph[current.currency] {
                for neighbor in neighbors {
                    if !visited.contains(neighbor.currency) {
                        queue.append((currency: neighbor.currency, rate: current.rate * neighbor.rate))
                    }
                }
            }
        }
        
        return nil
    }
}

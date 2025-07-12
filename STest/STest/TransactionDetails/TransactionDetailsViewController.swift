//
//  TransactionDetailsViewController.swift
//  STest
//
//  Created by Anita Stashevskaya on 12.07.2025.
//

import UIKit

final class TransactionDetailsViewController: UIViewController {
    private let viewModel: TransactionDetailsViewModel
    private let productSKU: String
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    private let totalLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(viewModel: TransactionDetailsViewModel, productSKU: String) {
        self.viewModel = viewModel
        self.productSKU = productSKU
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    private func setupUI() {
        title = "Transactions for \(productSKU)"
        view.backgroundColor = .systemBackground
        view.addSubview(totalLabel)
        view.addSubview(tableView)
        
        totalLabel.text = String(format: "Total: £%.2f", viewModel.totalGBP)
        
        NSLayoutConstraint.activate([
            totalLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            totalLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            totalLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            totalLabel.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: totalLabel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductListCell.self, forCellReuseIdentifier: "TransactionCell")
    }
}

extension TransactionDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.transactionDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! ProductListCell
        let detail = viewModel.transactionDetails[indexPath.row]
        
        let originalAmount = String(format: "%@%.2f", currencySymbol(detail.transaction.currency), detail.transaction.amount)
        let gbpAmount: String
        
        if let gbp = detail.gbpAmount {
            gbpAmount = String(format: "£%.2f", gbp)
        } else {
            gbpAmount = "N/A"
        }
        
        cell.configure(title: originalAmount, subtitle: gbpAmount)
        return cell
    }
    
    func currencySymbol(_ currencyCode: String) -> String {
        switch currencyCode {
        case "USD": return "$"
        case "GBP": return "£"
        case "AUD": return "A$"
        case "CAD": return "CA$"
        default:    return "\(currencyCode) "
        }
    }
}

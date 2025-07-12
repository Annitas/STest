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
    }
    
    private func setupUI() {
        title = "Transactions for \(productSKU)"
        view.backgroundColor = .systemBackground
        view.addSubview(totalLabel)
        totalLabel.text = String(format: "Total: £%.2f", viewModel.totalGBP)
        
        NSLayoutConstraint.activate([
            totalLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            totalLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            totalLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            totalLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

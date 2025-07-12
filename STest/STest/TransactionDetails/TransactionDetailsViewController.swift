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
    
    init(viewModel: TransactionDetailsViewModel, productSKU: String) {
        self.viewModel = viewModel
        self.productSKU = productSKU
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

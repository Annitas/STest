//
//  ViewController.swift
//  STest
//
//  Created by Anita Stashevskaya on 12.07.2025.
//

import UIKit

final class ProductListViewController: UIViewController {
    private let viewModel = ProductListViewModel()
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "Oops, product list is empty"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        updateEmptyLabelVisibility()
    }
    
    private func setupUI() {
        title = "Products"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(emptyLabel)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductListCell.self, forCellReuseIdentifier: "ProductCell")
    }
    
    private func updateEmptyLabelVisibility() {
        emptyLabel.isHidden = !viewModel.products.isEmpty
    }
}

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductListCell
        let product = viewModel.products[indexPath.row]
        let transactionsCount = viewModel.transactionCount(for: product)
        cell.configure(title: product, subtitle: "\(transactionsCount) transactions")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let product = viewModel.products[indexPath.row]
        let detailsViewModel = viewModel.getTransactionDetails(for: product)
        let detailsVC = TransactionDetailsViewController(viewModel: detailsViewModel, productSKU: product)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

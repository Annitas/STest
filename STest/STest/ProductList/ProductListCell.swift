//
//  ProductListCell.swift
//  STest
//
//  Created by Anita Stashevskaya on 12.07.2025.
//

import UIKit

final class ProductListCell: UITableViewCell {
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupLayout()
    }
    
    private func setupViews() {
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        subtitleLabel.font = UIFont.systemFont(ofSize: 15)
        subtitleLabel.textColor = .gray
        subtitleLabel.textAlignment = .right
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
    }
    
    private func setupLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            subtitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            subtitleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 8)
        ])
    }
    
    func configure(title: String, subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}

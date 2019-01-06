//
//  CurrenciesTableViewCell.swift
//  RevolutTest
//
//  Created by Gregory Oberemkov on 06/01/2019.
//  Copyright © 2019 Gregory Oberemkov. All rights reserved.
//

import UIKit

final class CurrenciesTableViewCell: UITableViewCell {

    // MARK: - Private properties
    
    private let abbreviationLabel = UILabel()
    private let currencyNameLabel = UILabel()
    private let currencyImage = UIImageView()
    private let currencyTextField = UITextField()
    
    // MARK: - Life cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        
        currencyImage.translatesAutoresizingMaskIntoConstraints = false
        currencyImage.contentMode = .scaleAspectFit
        contentView.addSubview(currencyImage)
        currencyImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        currencyImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        currencyImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        currencyImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        abbreviationLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(abbreviationLabel)
        abbreviationLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        abbreviationLabel.leftAnchor.constraint(equalTo: currencyImage.rightAnchor).isActive = true
        abbreviationLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        abbreviationLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        currencyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(currencyNameLabel)
        currencyNameLabel.topAnchor.constraint(equalTo: abbreviationLabel.bottomAnchor).isActive = true
        currencyNameLabel.leftAnchor.constraint(equalTo: currencyImage.rightAnchor).isActive = true
        currencyNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        currencyNameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        currencyTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(currencyTextField)
        currencyTextField.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        currencyTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        currencyTextField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
    }
    
}

// MARK: - Setupable

extension CurrenciesTableViewCell: Setupable {
    
    func setup(_ setupObject: CurrenicesCellViewModel) {
        abbreviationLabel.text = setupObject.abbreviation
        currencyNameLabel.text = setupObject.currencyName
        currencyImage.image = setupObject.image
        currencyTextField.text = setupObject.numberOfCurrency
    }
    
}

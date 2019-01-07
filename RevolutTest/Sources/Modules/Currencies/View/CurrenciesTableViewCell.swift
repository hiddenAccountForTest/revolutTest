//
//  CurrenciesTableViewCell.swift
//  RevolutTest
//
//  Created by Gregory Oberemkov on 06/01/2019.
//  Copyright © 2019 Gregory Oberemkov. All rights reserved.
//

import UIKit

final class CurrenciesTableViewCell: UITableViewCell {
    
    // MARK: - Delegate
    
    weak var delegate: CurrenciesStateChangeDelegate?

    // MARK: - Private properties
    
    let abbreviationLabel = UILabel()
    private let currencyNameLabel = UILabel()
    private let currencyImage = UIImageView()
    private let currencyTextField = UnderscoreTextField()
    
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
        
        selectionStyle = .none
        
        currencyImage.translatesAutoresizingMaskIntoConstraints = false
        currencyImage.contentMode = .scaleAspectFit
        contentView.addSubview(currencyImage)
        currencyImage.heightAnchor.constraint(equalToConstant: 65).isActive = true
        currencyImage.widthAnchor.constraint(equalToConstant: 65).isActive = true
        currencyImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        currencyImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        abbreviationLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(abbreviationLabel)
        abbreviationLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        abbreviationLabel.leftAnchor.constraint(equalTo: currencyImage.rightAnchor).isActive = true
        abbreviationLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        abbreviationLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        currencyNameLabel.textColor = .gray
        currencyNameLabel.adjustsFontSizeToFitWidth = true
        currencyNameLabel.minimumScaleFactor = 0.5
        currencyNameLabel.font = UIFont.systemFont(ofSize: 12)
        currencyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(currencyNameLabel)
        currencyNameLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        currencyNameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        currencyNameLabel.leftAnchor.constraint(equalTo: currencyImage.rightAnchor).isActive = true
        currencyNameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        currencyTextField.delegate = self
        currencyTextField.keyboardType = .numberPad
        currencyTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(currencyTextField)
        currencyTextField.leftAnchor.constraint(greaterThanOrEqualTo: currencyNameLabel.rightAnchor).isActive = true
        currencyTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        currencyTextField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
    }
    
}

// MARK: - UITextFieldDelegate

extension CurrenciesTableViewCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        
        guard let updatedText = updatedString, let number = Double(updatedText) else {
            return false
        }
        
        delegate?.changeMultiply(number)
        
        return true
    }
    
}

// MARK: - Setupable

extension CurrenciesTableViewCell: Setupable {
    
    func setup(_ setupObject: CurrenciesCellViewModel) {
        abbreviationLabel.text = setupObject.abbreviation
        currencyNameLabel.text = setupObject.currencyName
        currencyImage.image = setupObject.image
        currencyTextField.text = String(setupObject.numberOfCurrency)
    }
    
}

// MARK: - CurrencyCellObserver

extension CurrenciesTableViewCell: CurrencyCellObserver {
    
    func updateNumber(_ number: Double) {
        currencyTextField.text = String(number)
    }
    
}

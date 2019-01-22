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

    private let abbreviationLabel = UILabel()
    private let currencyNameLabel = UILabel()
    private let currencyImage = UIImageView()
    private let currencyTextField = UnderscoreTextField()

    private var isFirstCell: Bool?
    private var setupObject: CurrenciesCellViewModel?

    // MARK: - Life cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        currencyTextField.text = nil
        abbreviationLabel.text = nil
        currencyNameLabel.text = nil
        currencyImage.image = nil
        setupObject?.delegate = nil
        isFirstCell = nil
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
        currencyTextField.keyboardType = .decimalPad
        currencyTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(currencyTextField)
        currencyTextField.leftAnchor.constraint(greaterThanOrEqualTo: currencyNameLabel.rightAnchor).isActive = true
        currencyTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        currencyTextField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
    }

    @objc func onDidReceiveData(_ notification: Notification) {

        if let data = notification.userInfo as? [String: Float] {
            let number = data["number"]

            currencyTextField.text = "\(number! * Float(currencyTextField.text!)!)"
        }
    }
}

// MARK: - UITextFieldDelegate

extension CurrenciesTableViewCell: UITextFieldDelegate {
    
    // swiftlint:disable line_length
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard let isFirstCell = isFirstCell, let cellText = textField.text else {
            return false
        }
        
        if !isFirstCell {
            if let number = Float(cellText), let currencyAbbreviation = setupObject?.abbreviation {
                delegate?.replaceMainCurrency(currencyAbbreviation, withNumber: number)
            }
            return false
        } else {
            return true
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard let isFirstCell = isFirstCell,
              let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else {
            return false
        }

        if isFirstCell {
            if let number = Float(updatedString) {
                delegate?.changeMultiply(number)
            }
        }

        return true
    }

}

// MARK: - Setupable

extension CurrenciesTableViewCell: Setupable {

    func setup(_ setupObject: CurrenciesCellViewModel) {
        abbreviationLabel.text = setupObject.abbreviation
        currencyNameLabel.text = setupObject.currencyName
        currencyImage.image = setupObject.image
        isFirstCell = setupObject.isFirstCell
        self.setupObject = setupObject
        setupObject.delegate = self

        guard let floatNumber = Float(setupObject.numberOfCurrency) else {
            return
        }

        currencyTextField.text = String(format: "%.2f", floatNumber)
    }

}

// MARK: - CurrencyCellObserver

extension CurrenciesTableViewCell: CurrencyCellObserver {

    func updateNumber(_ number: String) {
        DispatchQueue.main.async {
            guard let firstCell = self.isFirstCell else {
                return
            }

            if !firstCell {

                guard let floatNumber = Float(number) else {
                    return
                }

                self.currencyTextField.text = String(format: "%.2f", floatNumber)
            }
        }
    }

}

//
//  PlaceholderTableViewCell.swift
//  RevolutTest
//
//  Created by Gregory Oberemkov on 20/01/2019.
//  Copyright © 2019 Gregory Oberemkov. All rights reserved.
//

import UIKit

final class PlaceholderTableViewCell: UITableViewCell {

    // MARK: - Private properties

    private let placeholderLabel = UILabel()

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

        placeholderLabel.text = "👽 Sorry, data not available 🛸"
        placeholderLabel.textAlignment = .center
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(placeholderLabel)

        placeholderLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        placeholderLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        placeholderLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        placeholderLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

}

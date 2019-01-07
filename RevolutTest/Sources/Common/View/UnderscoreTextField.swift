//
//  UnderscoreTextField.swift
//  RevolutTest
//
//  Created by Gregory Oberemkov on 07/01/2019.
//  Copyright © 2019 Gregory Oberemkov. All rights reserved.
//

import UIKit

final class UnderscoreTextField: UITextField {

    // MARK: - Life cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        underlined()
    }

    // MARK: - Private methods
    
    private func underlined() {
        let border = CALayer()
        let lineWidth = CGFloat(0.3)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - lineWidth, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = lineWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

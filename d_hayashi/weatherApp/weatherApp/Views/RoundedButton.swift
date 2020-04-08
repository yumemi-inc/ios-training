//
//  RoundedButton.swift
//  weatherApp
//
//  Created by 林 大地 on 2020/04/03.
//  Copyright © 2020 Daichi Hayashi. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CustomButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 20.0

    @IBInspectable var borderColor: UIColor = UIColor.clear
    @IBInspectable var borderWidth: CGFloat = 2.0

    override func draw(_ rect: CGRect) {

        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = (cornerRadius > 0)

        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth

        super.draw(rect)
    }
}

//
//  UILabel+Styles.swift
//  Weather
//
//  Created by Dhananjay Kumar Dubey on 20/1/21.
//

import Foundation
import UIKit

extension UILabel {
    
    func applyTitleStyle() {
        self.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        self.textColor = .black
    }
    
    func applyValueStyle() {
        self.font = UIFont.systemFont(ofSize: 15.0, weight: .medium)
        self.textColor = .black
    }
}

extension UIView {
    func applyCardViewStyle() {
        self.layer.cornerRadius = CGFloat(8.0)
        self.clipsToBounds = true
    }
}

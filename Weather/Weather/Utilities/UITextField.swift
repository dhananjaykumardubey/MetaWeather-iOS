//
//  UITextField.swift
//  Weather
//
//  Created by Dhananjay Kumar Dubey on 19/1/21.
//

import UIKit.UITextField

extension UITextField {
    
    func applyStyle() {
        self.font = UIFont.preferredFont(forTextStyle: .title3)
        self.textAlignment = .center
        self.textColor = UIColor.orange
        self.borderStyle = .roundedRect
        self.layer.borderWidth = CGFloat(1.0)
        self.layer.cornerRadius = CGFloat(8.0)
        self.layer.borderColor = UIColor.gray.withAlphaComponent(0.8).cgColor
        self.rightViewMode = .always
        self.tintColor = .clear
        self.addDoneButton()
    }
    
    /// Adds a Done button in textFields input accessory view
    func addDoneButton() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    /**
     Adds an image into a right view of textfield
     - parameters:
        - imageName: Image which needs to be added in textfield
     */
    func setupRightImage(imageName: String) {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        imageView.image = UIImage(named: imageName)?.tinted(with: .lightGray)
        let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 55, height: 40))
        imageContainerView.addSubview(imageView)
        self.rightView = imageContainerView
        self.rightViewMode = .always
        self.tintColor = .lightGray
    }
    
    @objc private func doneButtonAction(){
        self.resignFirstResponder()
    }
}

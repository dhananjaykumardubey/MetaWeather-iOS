//
//  UIViewController+Alerts.swift
//  Weather
//
//  Created by Dhananjay Kumar Dubey on 19/1/21.
//

import UIKit

extension UIViewController {
    /// Show Network alert on viewController.
    ///
    /// - Parameter title: Title for alert
    /// - Parameter message: message for alert
    /// - Parameter handler: handler for alert.
    @objc func showNetworkAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: UIAlertAction.Style.default,
                                      handler: handler))
        self.present(alert, animated: true, completion: nil)
    }
}

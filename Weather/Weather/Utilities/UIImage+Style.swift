//
//  UIImage+Style.swift
//  Weather
//
//  Created by Sushil Nagarale on 19/1/21.
//

import Foundation
import UIKit.UIImage

extension UIImage {
    
    /**
     Add tint color to an image
     - parameters:
         - color: Tint color to be applied on an image
         - returns: Returns a new image with tint color
     */
    func tinted(with color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        guard let ctx = UIGraphicsGetCurrentContext(), let cgImage = cgImage else { return self }
        color.setFill()
        ctx.translateBy(x: 0, y: size.height)
        ctx.scaleBy(x: 1.0, y: -1.0)
        ctx.clip(to: CGRect(x: 0, y: 0, width: size.width, height: size.height), mask: cgImage)
        ctx.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        guard let colored = UIGraphicsGetImageFromCurrentImageContext() else { return self }
        UIGraphicsEndImageContext()
        return colored
    }
}

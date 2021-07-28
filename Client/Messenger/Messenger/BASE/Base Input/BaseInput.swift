//
//  BaseInput.swift
//  HOPNHAT
//
//  Created by Trọng Tín on 27/05/2021.
//

import UIKit

class BaseInput: UITextField {
    var padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        self.borderStyle = .roundedRect
//        contrains()
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//        contrains()
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
//        contrains()
        return bounds.inset(by: padding)
    }
    
    func setupForImage(image: UIImage, distance: Int) {
        self.layer.cornerRadius = -10
        self.layer.masksToBounds = true
        backgroundColor = BaseColor.white_60.value
        padding = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 20)
        self.leftViewMode = .always
        let imageView = UIImageView(frame: CGRect(x: distance, y: 0, width: 32, height: 32))
        imageView.image = image
        let imageContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 32))
        imageContainerView.addSubview(imageView)
        leftView = imageContainerView
    }
    
    func setPadding (left: CGFloat, right: CGFloat) {
        padding = UIEdgeInsets(top: 0, left: left, bottom: 0, right: right)
    }
}

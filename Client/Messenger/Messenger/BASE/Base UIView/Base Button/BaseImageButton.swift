//
//  BaseButton.swift
//  HOPNHAT
//
//  Created by Trọng Tín on 18/06/2021.
//

import UIKit

class BaseImageButton: UIButton {
    
    var image: UIImage? {
        get {
            return UIImage(systemName: "exclamationmark.icloud.fill")!
        }
        set {
            self.setImage(newValue, for: .normal)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let image = self.image {
            self.setImage(image, for: .normal)
        }
//        imageView?.image = image
//        imageView?.contentMode = .scaleAspectFit
//        self.contentMode = .scaleAspectFit
        self.imageView?.translatesAutoresizingMaskIntoConstraints = false
        self.imageView?.contentMode = .scaleToFill
        self.imageEdgeInsets = UIEdgeInsets(top: 1,left: 1 ,bottom: 1,right: 1)
        self.imageView?.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.imageView?.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.imageView?.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.imageView?.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}

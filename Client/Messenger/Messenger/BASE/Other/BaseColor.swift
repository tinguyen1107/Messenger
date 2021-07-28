//
//  BaseColor.swift
//  HOPNHAT
//
//  Created by Trọng Tín on 27/05/2021.
//

import UIKit

enum BaseColor {
    case white_60
    case white_70
    case white_80

    case gray_80
    case gray_100
}

extension BaseColor {
    var value: UIColor {
        get {
            switch self {
            case .white_60:
                return UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
                
            case .white_70:
                return UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
                
            case .white_80:
                return UIColor(red: 1, green: 1, blue: 1, alpha: 0.8)
            case .gray_80:
                return UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 0.8)
            case .gray_100:
                return UIColor(red: 180/255, green: 180/255, blue: 180/255, alpha: 1)
            }
        }
    }
}

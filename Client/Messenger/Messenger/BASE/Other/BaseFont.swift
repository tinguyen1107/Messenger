//
//  BaseFont.swift
//  HOPNHAT
//
//  Created by Trọng Tín on 18/06/2021.
//

import UIKit

enum BaseFont {
    case bold
    case heavy
    case medium
    case regular
    case utraLight
    
    func value (size: CGFloat) -> UIFont {
        switch self {
        case .bold:
            return UIFont(name: "AvenirNext-Bold", size: size)!
        case .heavy:
            return UIFont(name: "AvenirNext-Heavy", size: size)!
        case .medium:
            return UIFont(name: "AvenirNext-Medium", size: size)!
        case .regular:
            return UIFont(name: "AvenirNext-Regular", size: size)!
        case .utraLight:
            return UIFont(name: "AvenirNext-UltraLight", size: size)!
        }
    }
}

//AvenirNext-Bold
//AvenirNext-BoldItalic
//AvenirNext-DemiBold
//AvenirNext-DemiBoldItalic
//AvenirNext-Heavy
//AvenirNext-HeavyItalic
//AvenirNext-Italic
//AvenirNext-Medium
//AvenirNext-MediumItalic
//AvenirNext-Regular
//AvenirNext-UltraLight
//AvenirNext-UltraLightItalic

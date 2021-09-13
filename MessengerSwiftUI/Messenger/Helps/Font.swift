//
//  Font.swift
//  Messenger
//
//  Created by Trọng Tín on 02/09/2021.
//

import Foundation
import SwiftUI

enum LocalFont {
    case h1, h2, h3
    case description
}

func localFont(_ type: LocalFont) -> Font? {
    switch type {
    case .h1:
        return Font.system(size: 40, weight: .semibold, design: .rounded)
    case .h2:
        return Font.system(size: 40, weight: .semibold, design: .rounded)
    case .h3:
        return Font.system(size: 40, weight: .semibold, design: .rounded)
        
    case .description:
        return Font.system(size: 18, weight: .medium, design: .rounded)
    }
}

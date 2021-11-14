//
//  AlertContent.swift
//  Messenger
//
//  Created by Tín Nguyễn on 14/11/2021.
//

import SwiftUI

struct AlertContent: Identifiable {
    var id: String { title }
    let title: String
    let description: String?
    let dismiss: Bool
}

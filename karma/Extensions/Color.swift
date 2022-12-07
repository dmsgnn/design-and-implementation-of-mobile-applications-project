//
//  ColorTheme.swift
//  karma
//
//  Created by Tommaso Bucaioni on 07/12/22.
//

import Foundation
import SwiftUI


extension Color {
    
    static let theme = ColorTheme()
    
}

struct ColorTheme {
    
    let accent = Color("AccentColor")
    let background = Color("backgroundColor")
    let dark = Color("DarkColor")
}

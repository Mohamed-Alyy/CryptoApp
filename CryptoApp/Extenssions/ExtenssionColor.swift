//
//  ExtenssionColor.swift
//  CryptoApp
//
//  Created by Mohamed Ali on 10/10/2023.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("accentColor")
    let red = Color("myRedColor", bundle: .main)
    let green = Color("myGreenColor")
    let secondaryTextColor = Color("secondaryTextColor")
    let backgroudColor = Color("backgroudColor")
    
}

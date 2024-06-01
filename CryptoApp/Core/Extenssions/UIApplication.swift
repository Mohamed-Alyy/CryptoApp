//
//  UIApplication.swift
//  CryptoApp
//
//  Created by Mohamed Ali on 18/03/2024.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func hasEndEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

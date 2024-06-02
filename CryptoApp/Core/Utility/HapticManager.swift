//
//  HapticManager.swift
//  CryptoApp
//
//  Created by Mohamed Ali on 01/06/2024.
//

import Foundation
import SwiftUI

class HapticManager {
    let generator = UINotificationFeedbackGenerator()
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType){
        generator.notificationOccurred(type)
    }
}

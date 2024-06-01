//
//  HapticManager.swift
//  CryptoApp
//
//  Created by Mohamed Ali on 01/06/2024.
//

import Foundation
import SwiftUI

class HapticManager {
    let genertaor = UINotificationFeedbackGenerator()
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType){
        genertaor.notificationOccurred(type)
    }
}

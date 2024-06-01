//
//  StatisticModel.swift
//  CryptoApp
//
//  Created by Mohamed Ali on 20/03/2024.
//

import Foundation

struct StatisticModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentagChange: Double?
    
    init(title: String, value: String, percentag: Double? = nil) {
        self.title = title
        self.value = value
        self.percentagChange = percentag
    }
}



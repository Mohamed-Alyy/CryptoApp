//
//  CoinsViewModelVIew.swift
//  CryptoApp
//
//  Created by Mohamed Ali on 07/03/2024.
//

import Foundation
import SwiftUI
import Combine

class CoinsViewModelView: ObservableObject {
    
  
    @Published var image: UIImage? = nil
    @Published var isLoaded:Bool = false
    
    var cancellacel : AnyCancellable?
    
    private var coins: CoinModel
    private var services: CoinImageServices
    
    init(coins: CoinModel){
        self.isLoaded = true
        self.coins = coins
        self.services = CoinImageServices(coin: coins)
        createSubription()
    }
    
    private func createSubription(){
        cancellacel = services.$image
            .sink {[weak self] _ in
                self?.isLoaded = false
            } receiveValue: {[weak self] returnedImage in
                self?.image = returnedImage
                self?.cancellacel?.cancel()
            }
    }
    
    
}

//
//  HomeVIewModel.swift
//  CryptoApp
//
//  Created by Mohamed Ali on 03/12/2023.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject{
    @Published var allCoins : [CoinModel] = []
    @Published var portfolioCoins : [CoinModel] = []
    
    private var coinsSrvices = CoinsDataServices()
    private var cancellabel = Set<AnyCancellable>()
    
    init(){
        addSubscriber()
    }
    
    func addSubscriber(){
        coinsSrvices.$coins
            .sink {[weak self] returndeCoins in
                self?.allCoins = returndeCoins
            }
            .store(in: &cancellabel)
    }
}

//
//  CoinDetailViewModel.swift
//  CryptoApp
//
//  Created by Mohamed Ali on 05/06/2024.
//

import Foundation
import Combine

class CoinDetailViewModel : ObservableObject {
    @Published var coin : CoinModel?
    
    private var cancellable = Set<AnyCancellable>()
    private let service: CoinDetailDataService
    
    init(coin: CoinModel){
        self.service = CoinDetailDataService(coin: coin)
        addCoinDetailSubsctiper()
    }
    
    
    func addCoinDetailSubsctiper(){
        service.$coin
            .map { coin -> CoinModel in
                return coin
            }
            .sink { [weak self] returnedCoin in
                self?.coin = returnedCoin
            }
            .store(in: &cancellable)
        
    }
}

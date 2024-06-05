//
//  CoinsDataServices.swift
//  CryptoApp
//
//  Created by Mohamed Ali on 04/03/2024.
//

import Foundation
import Combine

class CoinsDataServices {
    @Published var coins : [CoinModel] = []
    
    var conisSubscription : AnyCancellable?
    
    init(){
       getCoins()
    }
    
     func getCoins(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else {return}
        conisSubscription = NetworkManager.downloadData(url: url)
        
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handelSinkCompletion(completion:),
                  receiveValue: { [weak self] returnedImage in
                self?.coins = returnedImage
                self?.conisSubscription?.cancel()
            })
        
        
        
    }
}

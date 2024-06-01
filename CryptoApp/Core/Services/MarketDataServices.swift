//
//  MarketDataServices.swift
//  CryptoApp
//
//  Created by Mohamed Ali on 21/03/2024.
//

import Foundation
import Combine

class MarketDataServices {
    @Published var marketData : MarketDataModel? = nil
    
    var marketSubscription : AnyCancellable?
    
    init(){
        getMarketData()
    }
    
    private func getMarketData(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else {return}
        marketSubscription = NetworkManager.downloadData(url: url)
        
            .decode(type: MarketGlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handelSinkCompletion(completion:),
                  receiveValue: { [weak self] returnedGlobalData in
                self?.marketData = returnedGlobalData.data
                self?.marketSubscription?.cancel()
            })
        
        
        
    }
}

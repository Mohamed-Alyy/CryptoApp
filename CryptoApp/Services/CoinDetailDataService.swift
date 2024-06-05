//
//  CoinDetailDataService.swift
//  CryptoApp
//
//  Created by Mohamed Ali on 05/06/2024.
//

import Foundation
import Combine

class CoinDetailDataService {
    
    @Published var coin : CoinModel
    private var coinDetailSubscription : AnyCancellable?
    
    init(coin: CoinModel){
        self.coin = coin
        getCoinDetail()
    }
    
    
    func getCoinDetail(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else {return}
        
        coinDetailSubscription = NetworkManager.downloadData(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handelSinkCompletion(completion:), receiveValue: { returnedCoinDetail in
                print("Coind Details Downloaded From Api")
                print(returnedCoinDetail.description ?? "No Description founded")
                
            })
        
    }
    
    
    
}

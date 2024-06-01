//
//  HomeVIewModel.swift
//  CryptoApp
//
//  Created by Mohamed Ali on 03/12/2023.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject{
    @Published var statistic :  [StatisticModel] = []
    @Published var allCoins : [CoinModel] = []
    @Published var portfolioCoins : [CoinModel] = []
    @Published var markeData: MarketDataModel? = nil
    @Published var searchText: String = ""
    
    private var coinsServices = CoinsDataServices()
    private var marketServices = MarketDataServices()
    private var portfoliServices = PortfolioDataServices()
    
    private var cancellabel = Set<AnyCancellable>()
    
    init(){
        addSubscriber()
        
    }
    
    func addSubscriber(){
        
        // update all coins based on search text
        $searchText
            .combineLatest(coinsServices.$coins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink {[weak self] returndeCoins in
                self?.allCoins = returndeCoins
            }
            .store(in: &cancellabel)
        
        // update MarketData
        marketServices.$marketData
        // using map to convert returned data to our Model
            .map(subscribeToMarketData)
            .sink {[weak self] returndeMarketData in
                self?.statistic = returndeMarketData
            }
            .store(in: &cancellabel)
        
        
        // update potfolioCoins
        // combine allCoins with savedEntities Publishers whene any one of them was Updated
        $allCoins.combineLatest(portfoliServices.$savedEntities)
        // using [map] to convert returned data to our Model
            .map { coins , entites -> [CoinModel] in
                
                return coins
                // using [compactMap] to return only not nil values
                    .compactMap { coinModel -> CoinModel? in
                        // check if coin exist in entities
                        guard let entity = entites.first(where: {$0.id == coinModel.id}) else {
                            return nil
                        }
                        return coinModel.updateHolding(amount: entity.amount)
                    }
            }
            .sink {[weak self] returnedCoins in
                // store returned data from core data to portfolioCons array
                self?.portfolioCoins = returnedCoins
            }
            .store(in: &cancellabel)
        
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double){
        // add coin to core data
        portfoliServices.updatePortfolio(coin: coin, amount: amount)
    }
    
    private func filterCoins(text: String , coins: [CoinModel]) -> [CoinModel]{
        // if text isEmpty return all coins array
        guard !text.isEmpty else { return coins }
        
        // convet all letter to lowercase
        let lowerCaseText = text.lowercased()
        
        return coins.filter { coin  in
            coin.name.contains(lowerCaseText) ||
            coin.symbol.contains(lowerCaseText) ||
            coin.id.contains(lowerCaseText)
            
        }
    }
    
    
    func subscribeToMarketData(marketModel: MarketDataModel?)->[StatisticModel]{
        var statistics: [StatisticModel] = []
        
        guard let data = marketModel else {return statistics}
        
        let marketCap = StatisticModel(title: "MarketCap", value: data.marketCap, percentag: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC", value: data.btcDominance)
        let portfolio = StatisticModel(title: "Protfolio", value: "$0.00",percentag: 0.00)
        statistics.append(contentsOf: [marketCap,volume,btcDominance,portfolio])
        
        return statistics
            
    }
    
    
}





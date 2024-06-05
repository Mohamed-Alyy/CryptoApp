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
    @Published var isLoadingData: Bool = false
    @Published var sortOption: SortOptions = .hold
    
    private var coinsServices = CoinsDataServices()
    private var marketServices = MarketDataServices()
    private var portfoliServices = PortfolioDataServices()
    
    private var cancellabel = Set<AnyCancellable>()
    
    enum SortOptions{
        case hold , holdReversed , rank , rankReversed , price , priceReversed
    }
    
    init(){
        addSubscriber()  
    }
    
    func addSubscriber(){
        
        // update all coins based on search text
        $searchText
            .combineLatest(coinsServices.$coins,$sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(mapFiletrAndSortCoins)
            .sink {[weak self] returndeCoins in
                self?.allCoins = returndeCoins
            }
            .store(in: &cancellabel)
        
        // update potfolioCoins
        // combine allCoins with savedEntities Publishers whene any one of them was Updated
        $allCoins.combineLatest(portfoliServices.$savedEntities)
            .map(mapOfAllCoins)
            .sink {[weak self] returnedCoins in
                // store returned data from core data to portfolioCons array
                guard let self = self else {return}
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellabel)
        
        // update MarketData
        marketServices.$marketData
            .combineLatest($portfolioCoins)
        // using map to convert returned data to our Model
            .map(mapOfMarketData)
            .sink {[weak self] returndeMarketData in
                self?.statistic = returndeMarketData
                self?.isLoadingData = false
            }
            .store(in: &cancellabel)
        
    }
   
    //MARK: Public Methods
    func reloadData(){
        isLoadingData = true
        coinsServices.getCoins()
        marketServices.getMarketData()
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double){
        // add coin to core data
        portfoliServices.updatePortfolio(coin: coin, amount: amount)
    }
    
    //MARK: Private Methods
    private func sortPortfolioCoinsIfNeeded(coins: [CoinModel]) ->[CoinModel]{
        let filterdCoins = coins
        switch sortOption {
        case .hold:
            return filterdCoins.sorted(by: {$0.currentHoldingValue < $1.currentHoldingValue})
        case .holdReversed:
            return filterdCoins.sorted(by: {$0.currentHoldingValue > $1.currentHoldingValue})
            
        default:
            return filterdCoins
        }
    }
    
    private func mapFiletrAndSortCoins(text: String , coins: [CoinModel], sort: SortOptions) -> [CoinModel]{
        var filterdCoins = filterCoins(text: text, coins: coins)
        sortCoins(coins: &filterdCoins, sort: .price)
        return filterdCoins
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
    
    
    private func sortCoins(coins:inout [CoinModel], sort: SortOptions){
        
        switch sortOption {
        case .hold , .rank:
            coins.sort(by: {$0.rank < $1.rank})
        case .holdReversed, .rankReversed:
             coins.sort(by: {$0.rank > $1.rank})
        case .price:
             coins.sort(by: {$0.currentPrice ?? 0 > $1.currentPrice ?? 0})
        case .priceReversed:
             coins.sort(by: {$0.currentPrice ?? 0 < $1.currentPrice ?? 0})
        }
    }
    
    private func mapOfAllCoins(coins:[CoinModel], entities: [PortfoliEntity])-> [CoinModel]{
        return coins
        // using [compactMap] to return only not nil values
            .compactMap { coinModel -> CoinModel? in
                // check if coin exist in entities
                guard let entity = entities.first(where: {$0.id == coinModel.id}) else {
                    return nil
                }
                return coinModel.updateHolding(amount: entity.amount)
            }
    }
    
    private func mapOfMarketData(marketModel: MarketDataModel? , portfolioCoin: [CoinModel])->[StatisticModel]{
        var statistics: [StatisticModel] = []
        
        guard let data = marketModel else {return statistics}
        
        // show sum of portfolio values in market data view
        let portfolioValue = portfolioCoin.map { $0.currentHoldingValue}
            .reduce(0, +)
        
        // show sum of portfolio values percentage in market data view
        let previousValue = portfolioCoin.map { coin -> Double in
            let currentHoldingValue = coin.currentHoldingValue
            let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
            let previousValue = currentHoldingValue / (1 + percentChange)
            
            return previousValue
        }
            .reduce(0, +)
        
        let percantChange = ((portfolioValue -  previousValue) / previousValue) * 100
        
        let marketCap = StatisticModel(title: "MarketCap", value: data.marketCap, percentag: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC", value: data.btcDominance)
        
        let portfolioValues = StatisticModel(title: "Protfolio",
                                             value: portfolioValue.asAcurrencyWith2Decimal(),
                                             percentag: percantChange)
        
        statistics.append(contentsOf: [marketCap,volume,btcDominance,portfolioValues])
        
        return statistics
        
    }
    
    
}





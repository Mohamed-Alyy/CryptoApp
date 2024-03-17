
import Foundation
import SwiftUI
import Combine


class CoinsImageVeiwModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoaded:Bool = false
 
    var cancellable = Set<AnyCancellable>()
    
    var imageServices: CoinImageServices
    var coin: CoinModel
    
    init(coin: CoinModel){
        self.coin = coin
        self.imageServices = CoinImageServices(coin: coin )
        self.isLoaded = true
        getCoinImageSubscribe()
    }
    
    
    private func getCoinImageSubscribe(){
        imageServices.$image
            .sink {[weak self] _ in
                self?.isLoaded = false
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            }
            .store(in: &cancellable)

    }
}

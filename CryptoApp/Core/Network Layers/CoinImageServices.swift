
//  Created by Mohamed Ali on 06/03/2024.
//

import Foundation
import SwiftUI
import Combine

class CoinImageServices {
    @Published var image: UIImage? = nil
    @Published var imageSubscription : AnyCancellable?
    
    // 1- create this reference to get url from coin.image?
    private let coin: CoinModel

   
    init(coin: CoinModel) {
        self.coin = coin
        getCoinsImage()
    }
    
    //2- when we call this function in coinsViewModel we need url
    
    private func getCoinsImage(){
        guard
            let imageUrl = coin.image,
            let url = URL(string: imageUrl) else {return}
        
        imageSubscription = NetworkManager.downloadData(url: url)
            .tryMap { data -> UIImage? in
                let imageData = UIImage(data: data)
             
                return imageData
                
            }
            .sink(receiveCompletion: (NetworkManager.handelSinkCompletion)) { [weak self] returnedImage in
                self?.image = returnedImage
                self?.imageSubscription?.cancel()
            }
    }
    
    
    
    
}

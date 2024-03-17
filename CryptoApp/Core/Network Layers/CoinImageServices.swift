
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

    let cFManager = CoinFIleManager.instance
   
    init(coin: CoinModel) {
        self.coin = coin
        getSavedImage()
    }
    

    
    private func getSavedImage(){
        
        if let savedImage = cFManager.get(imageName: coin.id){
            //print("get saved image")
            image = savedImage
        }else{
            //print("get live image")
            fetchCoinsImage()
        }
        
    }
    
    //2- when we call this function in coinsViewModel we need url
    
    private func fetchCoinsImage(){
        guard
            let imageUrl = coin.image,
            let url = URL(string: imageUrl) else {return}
        
        imageSubscription = NetworkManager.downloadData(url: url)
            .tryMap { data -> UIImage? in
                let imageData = UIImage(data: data)
                return imageData
            }
            .sink(receiveCompletion: (NetworkManager.handelSinkCompletion)) { [weak self] returnedImage in
                guard 
                    let self = self,
                    let image = returnedImage else {return}
                
                cFManager.add(imageName: coin.id, image: image)
                self.imageSubscription?.cancel()
            }
    }
    
    
    
    
}

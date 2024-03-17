//
//  CoinsPhotoView.swift
//  CryptoApp
//
//  Created by Mohamed Ali on 07/03/2024.
//

import Foundation
import SwiftUI
import Combine


class CoinsPhotoServices {
    
    
    @Published var image: UIImage? = nil
    @Published var imageSubscription : AnyCancellable?
   
    private var coins : CoinModel
    
    init(coins: CoinModel){
        self.coins = coins
        getImage()
    }
    
    
    private func getImage(){
        guard
            let imageUrl = coins.image,
            let url = URL(string: imageUrl) else {return}
        imageSubscription = NetworkManager.downloadData(url: url)
            .tryMap { data -> UIImage? in
                return UIImage(data: data)
            }
            .sink(receiveCompletion: (NetworkManager.handelSinkCompletion(completion:))) { [weak self] returnedImage in
                self?.image = returnedImage
                self?.imageSubscription?.cancel()
            }
            
    }
}

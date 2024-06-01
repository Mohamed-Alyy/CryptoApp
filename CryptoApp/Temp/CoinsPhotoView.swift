//
//  CoinsPhotoView.swift
//  CryptoApp
//
//  Created by Mohamed Ali on 07/03/2024.
//

import SwiftUI

struct CoinsPhotoView: View {
    @StateObject var vm: CoinsViewModelView
    
    init(coins:CoinModel){
        _vm = StateObject(wrappedValue: CoinsViewModelView(coins: coins))
    }
    
    
    var body: some View {
        ZStack{
            if let image = vm.image {
               Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }else if vm.isLoaded{
                ProgressView()
                    
            }else{
                Image(systemName: "questionmark")
            }
            
        }
    }
}

#Preview {
    CoinsPhotoView( coins: DeveloperPreview.instance.coin)
}

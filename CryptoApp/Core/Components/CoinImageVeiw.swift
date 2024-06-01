//
//  CoinImageVeiw.swift
//  CryptoApp
//
//  Created by Mohamed Ali on 06/03/2024.
//

import SwiftUI



struct CoinImageVeiw: View {
    @StateObject var vm: CoinsImageVeiwModel
    let manager = CoinFIleManager.instance
    init(coin:CoinModel) {
        _vm = StateObject(wrappedValue: CoinsImageVeiwModel(coin: coin))
    }
    
    var body: some View {
        ZStack{
  
             
            if let image = vm.image{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }else if vm.isLoaded {
                ProgressView()

            }else{
                Image(systemName: "questionmark.circle")
                    .font(.title)
                    .foregroundStyle(Color.theme.secondaryTextColor)
            }
        }
      
    }
}

#Preview {
    CoinImageVeiw(coin: DeveloperPreview.instance.coin)
}

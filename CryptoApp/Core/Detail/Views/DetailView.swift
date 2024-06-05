//
//  DetailView.swift
//  CryptoApp
//
//  Created by Mohamed Ali on 04/06/2024.
//

import SwiftUI

struct CoinDetailView: View {
    @StateObject var vm: CoinDetailViewModel
    let coin: CoinModel?
    init(coin: CoinModel){
        self.coin = coin
        _vm = StateObject(wrappedValue: CoinDetailViewModel(coin: coin))
    }
    var body: some View {
        ZStack{
            if let coin {
                Text(coin.name)
            }else{
                Text("No Coin to Preview")
            }
        }
      
        
    }
}

struct DetailView: View {
    @Binding var coin: CoinModel?
    
    init(coin: Binding<CoinModel?>) {
        self._coin = coin
        print("initilizer for coin \(coin.wrappedValue?.name)")
    }
    var body: some View {
        CoinDetailView(coin: coin!)
        
    }
}

#Preview {
    DetailView(coin: .constant(DeveloperPreview.instance.coin))
}

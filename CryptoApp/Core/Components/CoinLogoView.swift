//
//  CoinLogoView.swift
//  CryptoApp
//
//  Created by Mohamed Ali on 28/03/2024.
//

import SwiftUI

struct CoinLogoView: View {
    let coin : CoinModel
    var body: some View {
        
        VStack {
            CoinImageVeiw(coin: coin)
                .frame(width: 60)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .foregroundStyle(Color.theme.accent)
            
            Text(coin.name.uppercased())
                .font(.caption)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .foregroundStyle(Color.theme.accent)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    CoinLogoView(coin: DeveloperPreview.instance.coin)
}

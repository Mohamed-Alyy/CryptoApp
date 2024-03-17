//
//  CoinsRowVIew.swift
//  CryptoApp
//
//  Created by Mohamed Ali on 04/11/2023.
//

import SwiftUI

struct CoinRowView: View {
    let coin: CoinModel
    var showHoldingCloumn: Bool
    
    var body: some View {
        HStack (spacing:0){
            leftCloumn
            
            Spacer()
            
            if showHoldingCloumn{
                holdingCloumn
            }
           // Spacer()
            rightCloumn
        }//Full Hstack
    }//body
}//struct

struct CoinRow_preview: PreviewProvider{
    static var previews: some View {
        CoinRowView( coin: dev.coin, showHoldingCloumn: true)
            .previewLayout(.sizeThatFits)
    }
}


extension CoinRowView {
    
    private var leftCloumn : some View {
        HStack(spacing:0){
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryTextColor)
                .frame(minWidth: 30)
           // Circle()
            CoinImageVeiw(coin: coin)
                .frame(width: 40)
            Text(coin.symbol.uppercased())
                .padding(6)
        }
    }
    
    
    private var holdingCloumn : some View {
        VStack(alignment: .trailing){
            Text(coin.currentHoldingValue.asAcurrencyWith2Decimal())
                .bold()
            Text((coin.currentHolding ?? 0).asNumberString())
        }
        .foregroundStyle(Color.theme.accent)
    }
    
    
    private var rightCloumn : some View {
        VStack(alignment: .trailing){
            Text(coin.currentPrice?.asAcurrencyWith2Decimal() ?? "$0.00")
                .bold()
            Text((coin.priceChangePercentage24H?.asPercentString() ?? ""))
                .foregroundStyle(coin.priceChangePercentage24H ?? 0 >= 0 ? Color.theme.green: Color.theme.red)
        }
        .frame(width: UIScreen.main.bounds.width/3.5, alignment: .center)
    }
    
    
    
}

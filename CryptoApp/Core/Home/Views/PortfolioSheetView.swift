//
//  PortfolioSheetView.swift
//  CryptoApp
//
//  Created by Mohamed Ali on 27/03/2024.
//

import SwiftUI

struct PortfolioSheetView: View {
    @EnvironmentObject private var vm : HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var textquantity = ""
    @State private var showCheckMark:Bool = false
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    
                    SearchBarView(searchBarText:$vm.searchText)
                    showCoinsList
                    if (selectedCoin != nil) {
                        VStack{
                            HStack{
                                Text(selectedCoin?.symbol.uppercased() ?? "")
                                Spacer()
                                Text(selectedCoin?.currentPrice?.asAcurrencyWith2Decimal() ?? "")
                            }
                            Divider()
                            
                            HStack{
                                Text("Amount in your portfolio...")
                                    .font(.caption)
                                    .lineLimit(1)
                                Spacer()
                                TextField("Ex 1.5", text: $textquantity)
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.trailing)
                                    .font(.headline)
                            }
                            Divider()
                            
                            HStack{
                                Text("Current Value:")
                                Spacer()
                                Text(getCurrentValue().asAcurrencyWith2Decimal())
                                
                            }
                        }
                        .padding()
                    }
                }
                .toolbar(content: {
                    ToolbarItem(placement:.topBarLeading) {
                        XMarkButtonView()
                    }
                    
                    ToolbarItem (placement:.automatic) {
                        HStack{
                            Button(action: {
                                saveButtonPressed()
                            }, label: {
                                Image(systemName: "checkmark")
                                    .opacity(showCheckMark ? 1.0 : 0.0)
                                Text("Save")
                                    .foregroundStyle(Color.theme.accent)
                                    .opacity(selectedCoin == nil ? 0 : 1)
                            })
                        }
                      
                    }

                })
                
            }
            .navigationTitle("Edite Portfolio")
            //.foregroundStyle(Color.theme.accent)
        }
        
    }
        
}

#Preview {
    PortfolioSheetView()
        .environmentObject(DeveloperPreview.instance.homeVM)
}

extension PortfolioSheetView {
    private var showCoinsList: some View {
        ScrollView(.horizontal, showsIndicators: false){
            LazyHStack{
                // showing list depending on this tow criteria
                ForEach(vm.searchText.isEmpty ? vm.portfolioCoins.isEmpty ? vm.allCoins : vm.portfolioCoins : vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 80)
                        .padding(4)
                        .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear, lineWidth: 1.5)
                        )
                        .onTapGesture {
                            selectedCoin = coin
                            updateCurrentCoint(coin: coin)
                        }
                }
            }
            .padding(.horizontal,4)
            .padding(.leading)
        }
    }
    
   private func getCurrentValue()->Double {
        if let quantity = Double(textquantity){
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        
        return 0
    }
    
    private func updateCurrentCoint(coin:CoinModel){
        selectedCoin = coin
        if let portfolioCoin = vm.portfolioCoins.first(where: {$0.id == coin.id}),
           let amount = portfolioCoin.currentHolding
        {
            textquantity = "\(amount)"
        }else{
            textquantity = ""
        }
    }
    
    private func saveButtonPressed(){
        guard 
            let coin = selectedCoin,
            let amount = Double(textquantity)
            else {return}
        // save to portfolio using core data
        vm.updatePortfolio(coin: coin, amount: amount)
        
        // show check Mark
        withAnimation {
            showCheckMark = true
            removeSelectedCoin()
        }
       
        // hide keyboard
        UIApplication.shared.hasEndEditing()

        // hide check Mark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            withAnimation(.easeInOut){
                showCheckMark = false
            }
        })
    }
    
    
    private func removeSelectedCoin(){
        selectedCoin = nil
        vm.searchText = ""
        textquantity = ""
    }
}

//
//  MainView.swift
//  CryptoApp
//
//  Created by Mohamed Ali on 10/10/2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm : HomeViewModel
    @State private var showPortfolio: Bool = false // animate
    @State private var showPorfolilSheetView: Bool = false // Segue new sheet
    @State private var showDetailView: Bool = false
    @State private var selectedCoin: CoinModel? = nil
    
    
    var body: some View {
        
        ZStack{
            Color.theme.backgroudColor
                .ignoresSafeArea()
                .sheet(isPresented: $showPorfolilSheetView, content: {
                    PortfolioSheetView()
                        .environmentObject(vm)
                        
                })
            
            VStack{
                homeHeader
                HomeStatsView(showPortfolio: $showPortfolio)
                SearchBarView(searchBarText: $vm.searchText)
                columnTitle
                
                if showPortfolio{
                    portfolioCoins
                }else{
                    allCoins
                        
                }
                Spacer(minLength: 0)
            }
            //TODO: delete this and use NavigationLink to present DetailView
            .sheet(isPresented: $showDetailView, content: {
                DetailView(coin: $selectedCoin)
            })
            
            
            //MARK: ShowDetailView Navigation
//            .background(
//                    NavigationLink(value: showDetailView) {
//                        DetailView(coin: $selectedCoin)
//                    }
//            )
        }
      
    
    }
        
}

#Preview {
    HomeView()
        .environmentObject(DeveloperPreview.instance.homeVM)
}


extension HomeView {
    private var homeHeader: some View {
        HStack{
            CircleButtonView(imageName: showPortfolio ? "plus" : "info" )
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
                .onTapGesture {
                    withAnimation(.spring) {
                        showPorfolilSheetView.toggle()
                    }
                }
            
            Spacer()
            
            Text(showPortfolio ?  "Portfolio": "Live Precise")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
            
            Spacer()
            
            CircleButtonView(imageName: "chevron.left")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring) {
                        showPortfolio.toggle()
                    }
                }
        }
    }
    
    
    private var allCoins: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingCloumn: false)
                    .onTapGesture {
                        detailViewSegue(coin:coin)
                    }
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
        .transition(.move(edge: .leading))
    }
    
  
    
    private var portfolioCoins: some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingCloumn: true)
                    .onTapGesture {
                        detailViewSegue(coin: coin)
                    }
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
        .transition(.move(edge: .trailing))
    }
    
    private var columnTitle: some View {
        HStack{
            HStack{
                Image(systemName: "chevron.down")
                    .opacity(( vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1 : 0)
                    .rotationEffect(Angle(degrees:( vm.sortOption == .rank) ? 180 : 0))
                Text("Coin")
            }
            .onTapGesture {
                withAnimation {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            
            Spacer()
            if showPortfolio{
                HStack{
                    
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .hold || vm.sortOption == .holdReversed) ? 1 : 0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .hold ? 180 : 0))
                    Text("Holding")
                }
                .onTapGesture {
                    withAnimation {
                        vm.sortOption = vm.sortOption == .hold ? .holdReversed : .hold
                    }
                }

            }
            HStack{
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1 : 0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 180 : 0))
                Text("Prices")
            }
            .onTapGesture {
                withAnimation {
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }
            }
            
            .frame(width: UIScreen.main.bounds.width/3.5,alignment: .trailing)
            // press Button to refresh data
            Button(action: {
                withAnimation(.linear(duration: 2)) {
                    vm.reloadData()
                    // make vibration whene data loaded
                    HapticManager().notification(type: .success)
                }
            }, label: {
                Image(systemName: "goforward")
            })
            .rotationEffect(Angle(degrees: vm.isLoadingData ? 360 : 0))
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryTextColor)
        .padding(.horizontal)
    }
    
    
    
    private func detailViewSegue(coin:CoinModel){
        selectedCoin = coin
        showDetailView.toggle()
          
      }
}


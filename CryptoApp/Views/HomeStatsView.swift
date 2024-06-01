//
//  HomeStatsView.swift
//  CryptoApp
//
//  Created by Mohamed Ali on 20/03/2024.
//

import SwiftUI

struct HomeStatsView: View {
   
    
    @EnvironmentObject private var vm : HomeViewModel
    
    @Binding var showPortfolio: Bool
    
    var body: some View {
        HStack{
            ForEach(vm.statistic) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width,alignment: showPortfolio ? .trailing : .leading)
    }
}

#Preview {
    HomeStatsView(showPortfolio: .constant(false))
        .environmentObject(DeveloperPreview.instance.homeVM)
}

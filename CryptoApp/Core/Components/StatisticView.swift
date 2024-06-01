//
//  StatisticView.swift
//  CryptoApp
//
//  Created by Mohamed Ali on 20/03/2024.
//

import SwiftUI

struct StatisticView: View {
    let stat : StatisticModel
    var body: some View {
        VStack(alignment:.leading){
            Text(stat.title)
                .font(.headline)
                .foregroundStyle(Color.theme.secondaryTextColor)
            Text(stat.value)
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
            HStack (spacing: 2){
                Image(systemName: "triangle.fill")
                    .font(.footnote)
                    .rotationEffect(
                        Angle(degrees: stat.percentagChange ?? 0 >= 0 ? 0 : 180)
                    )
                Text(stat.percentagChange?.asPercentString() ?? "")
                    .font(.callout)
                    .bold()
                
            }
            .foregroundStyle((stat.percentagChange ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
            .opacity(stat.percentagChange == nil ? 0 : 1)
        }
    }
}

#Preview {
    StatisticView(stat: DeveloperPreview.instance.stat1)
     //  .previewLayout(.sizeThatFits)
}

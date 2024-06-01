//
//  SearchBarView.swift
//  CryptoApp
//
//  Created by Mohamed Ali on 18/03/2024.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchBarText: String
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .padding(.leading)
                .foregroundStyle(searchBarText.isEmpty ?
                                 ColorTheme().secondaryTextColor : ColorTheme().accent )
            TextField(text: $searchBarText) {
                Text("Search by name or symbol...")
                    
            }
            .font(.headline)
            .autocorrectionDisabled(true)
            .scrollDismissesKeyboard(.automatic)  // check
            .foregroundStyle(ColorTheme().accent)
            .padding()
          
            
        }
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(ColorTheme().backgroudColor)
                .shadow(color: ColorTheme().secondaryTextColor.opacity(0.25), radius: 10)
        )
        .overlay(alignment: .trailing, content: {
            Image(systemName: "xmark.circle.fill")
                .foregroundStyle(ColorTheme().accent)
                .opacity(searchBarText.isEmpty ? 0 : 1.0)
                .padding()
                .offset(x: -10)
                .onTapGesture {
                    UIApplication.shared.hasEndEditing()
                    searchBarText = ""
                }
        })
        
        .padding()
    }
}

#Preview {
    SearchBarView(searchBarText: .constant(""))
}

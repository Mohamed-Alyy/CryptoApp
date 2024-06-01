//
//  XMarkButtonView.swift
//  CryptoApp
//
//  Created by Mohamed Ali on 27/03/2024.
//

import SwiftUI

struct XMarkButtonView: View {
    @Environment(\.presentationMode) var isPresented
    var body: some View {
        Button(
            action: {isPresented.wrappedValue.dismiss()},
            label: {
            Image(systemName: "xmark")
                    .font(.headline)
                    .foregroundStyle(Color.theme.accent)
        })
    }
}

#Preview {
    XMarkButtonView()
}

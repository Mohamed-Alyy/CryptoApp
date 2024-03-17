//
//  CircleButtonAnimationView.swift
//  CryptoApp
//
//  Created by Mohamed Ali on 11/10/2023.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    @Binding  var animate: Bool
    var body: some View {
        Circle()
       
            .stroke(style: StrokeStyle(lineWidth: 4))
            .scale(animate ? 1 : 0)
            .opacity(animate ? 0 : 1)
            .animation(animate ? .easeInOut(duration: 1.3) : .none, value: animate)

    }
}

#Preview {
    CircleButtonAnimationView(animate: .constant(false))
        .backgroundStyle(.myRed)
        .frame(width:200)
       
}



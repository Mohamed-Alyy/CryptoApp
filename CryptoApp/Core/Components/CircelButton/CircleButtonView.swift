//
//  CircelButton.swift
//  CryptoApp
//
//  Created by Mohamed Ali on 11/10/2023.
//

import SwiftUI
// we can import this view in any view with name for image
struct CircleButtonView: View {
    let imageName: String
    
    var body: some View {
        Image(systemName: imageName)
            .font(.headline)
            .foregroundStyle(Color.theme.accent)
            .frame(width: 50,height: 50)
            .background(
                Circle()
                    .foregroundStyle(Color.theme.backgroudColor)
            )
            .shadow(color: Color.theme.accent.opacity(0.25), radius: 10, x: 0, y: 0)
            .padding()
            
    }
}


#Preview {
    Group{
        CircleButtonView(imageName: "info")
            .previewLayout(.sizeThatFits)
        CircleButtonView(imageName: "plus")
            .colorScheme(.light)
        CircleButtonView(imageName: "heart.fill")

    }
}

//struct CircleButtonView_preview: PreviewProvider {
//    static var previews: some View{
//        Group{
//            CircleButtonView(imageName: "info")
//                .previewLayout(.sizeThatFits)
//            CircleButtonView(imageName: "plus")
//                .colorScheme(.dark)
//                .previewLayout(.sizeThatFits)
//
//        }
//    }
//}

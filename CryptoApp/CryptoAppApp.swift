//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by Mohamed Ali on 10/10/2023.
//

import SwiftUI

@main
struct CryptoAppApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var vm = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView()
//                    .navigationBarHidden(true)
                    .toolbar(.hidden)
                //            ContentView()
                //                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
            .environmentObject(vm)
        }
    }
}

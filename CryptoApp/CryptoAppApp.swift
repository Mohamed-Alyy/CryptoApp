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
    
    // controls app theme colours
    init(){
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView()
                    .toolbar(.hidden)
                                
            }
            .environmentObject(vm)
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

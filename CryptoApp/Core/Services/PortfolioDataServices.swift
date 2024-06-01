//
//  PortfolioDataServices.swift
//  CryptoApp
//
//  Created by Mohamed Ali on 24/05/2024.
//

import Foundation
import CoreData

class PortfolioDataServices {
//    @Environment(\.managedObjectContext) var context
    private let context = PersistenceController.shared.container.viewContext
    private let entityName = "PortfoliEntity"
    
    @Published var savedEntities : [PortfoliEntity] = []
    
    init(){
        getPortfolioData()
    }

    //MARK: Core Data Private Methods
    private func getPortfolioData(){
        let request = NSFetchRequest<PortfoliEntity>(entityName: entityName)
        
        do{
           savedEntities = try context.fetch(request)
        }catch let error{
            print(error.localizedDescription)
        }
    }
   
    private func save(){
       // let context = container.viewContext
        if context.hasChanges{
            do{ try context.save()}
            
            catch let error { print("Error with protfolio save",error.localizedDescription)}
        }
        print("Data Saved", savedEntities.count)
    }
    
    
    private func applayChanges(){
        save()
        getPortfolioData()
       
    }
    
    private func add(coin: CoinModel , amount: Double){
        let entity = PortfoliEntity(context: context)
        entity.id = coin.id
        entity.amount = amount
        applayChanges()
    }
    
    private func update(entity: PortfoliEntity, amount:Double){
        entity.amount = amount
        applayChanges()
    }
    
    private func delete(entity: PortfoliEntity){
        context.delete(entity)
        applayChanges()
    }
    
    //MARK: Core Data Public Methods
    
    func updatePortfolio(coin: CoinModel,amount: Double){
        // check if coin exist in savedEntity array
        if let entity = savedEntities.first(where: {$0.id == coin.id}){
            // if new amount > 0 update old amount with new amount
            if amount > 0 {
                update(entity: entity, amount: amount)
            }else{
                // if new amount < 0 delete this entity
                delete(entity: entity)
            }
        }else{
            // if new coind dont exist in array add it as new entity
            add(coin: coin, amount: amount)
        }
    }
    
}




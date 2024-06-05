//
//  CoinFIleManager.swift
//  CryptoApp
//
//  Created by Mohamed Ali on 17/03/2024.
//

import Foundation
import SwiftUI

class CoinFIleManager {
    static let instance = CoinFIleManager()
    
    let fm = FileManager.default
    let folderName = "Coin_Images"
    
    
    private init () {
        createFolder()
    }
    
    private func createFolder(){
        guard
            let path = getFolderPath() else {return}
        if !fm.fileExists(atPath: path.path()){
            do {
                try  fm.createDirectory(at: path, withIntermediateDirectories: true)
                print("Folder \(folderName) created successfully")
            } catch let error {
                print(error.localizedDescription)
            }
           
        }
    }
    
    private func getFolderPath(  )-> URL?{
        guard
            let folderPath = fm.urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appending(path: folderName) else {return nil}
        return folderPath
    }
    
    private func getImagePath(imageName: String)-> URL?{
        guard let imagePath = getFolderPath() else {return nil}
        
        return imagePath.appending(component: imageName + ".png")
    }
    
    
    func add(imageName: String , image: UIImage){
        guard
            let imageData = image.pngData(),
            let imagePath = getImagePath(imageName: imageName) else {return}
        if !fm.fileExists(atPath: imagePath.path()){
            do {
                try  imageData.write(to: imagePath)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
       
    }
    
    func get(imageName: String)-> UIImage?{
        guard let imagePath = getImagePath(imageName: imageName)?.path() else {return nil}
        if !fm.fileExists(atPath: imagePath){
           return nil
        }else{
            return UIImage(contentsOfFile: imagePath)
        }
    }
    
    func remove(imageName: String){
        guard let imagePath = getImagePath(imageName: imageName) else {return}
        if fm.fileExists(atPath: imagePath.path()){
            do {
                try fm.removeItem(at: imagePath)
                print("image deleting successfully")
            } catch let error {
                print("Error with deleting image: \(imageName). \(error.localizedDescription)")
            }
            
        }
    }
    
}

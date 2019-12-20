//
//  FavouriteWebFilm.swift
//  WebFilmChallange
//
//  Created by Zespół ds Środowiska Pracy IT on 20/12/2019.
//  Copyright © 2019 Piotr Buczma. All rights reserved.
//

import Foundation


class FavouriteWebFilm: NSObject, NSCoding{
    
    private var favourite: [Int] = []
    
    static var documentDirecotry = FileManager().urls(for: .documentDirectory, in: .allDomainsMask).first!
    static let archiveURL = documentDirecotry.appendingPathComponent("Favourite")
        
    
    
    init(favourite: [Int]){
        self.favourite = favourite
    }
    
    struct PropertyKey {
        
        static let favourite = "favourite"
    }
    
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(self.favourite, forKey: PropertyKey.favourite)
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        
        guard let favourite = aDecoder.decodeObject(forKey: PropertyKey.favourite) as? [Int] else {
            fatalError("FavouriteWebFilm.init?-favourite is null")
        }
        
        self.init(favourite: favourite)
        
    }
    
    func isFavourite( webFilm: WebFilm ) -> Bool{
        
        if favourite.contains(webFilm.id){
            return true
        }else{
            return false
        }
        
    }
    
    func modifyFavourite(webFilm: WebFilm){
        
        if webFilm.favourie {
            
            if !isFavourite(webFilm: webFilm){
                favourite.append(webFilm.id)
            }
            
        }else{
            
            if isFavourite(webFilm: webFilm){
                if let index = favourite.firstIndex(of: webFilm.id) {
                    favourite.remove(at: index)
                }
            }
        }
        
    }
    
    public func getFavourite( webFilm: [WebFilm]) -> [WebFilm]{
        
        var newWebFilm:[WebFilm] = []
        
        for var aFilm in webFilm{
            
            aFilm.favourie =  isFavourite(webFilm: aFilm)
            newWebFilm.append(aFilm)
        
        }
        
        return newWebFilm
    }
    
    
    public static func saveFavourite(appRights: FavouriteWebFilm){
           print("FavouriteWebFilm - saveFavourite: trying to save \(FavouriteWebFilm.archiveURL.path)")
           let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(appRights, toFile: FavouriteWebFilm.archiveURL.path)
           
           if isSuccessfulSave {
               print("FavouriteWebFilm - saveFavourite saved")
           }else{
               print("FavouriteWebFilm - saveFavourite problem saving")
           }
       }

       
       public static func loadFavourite() -> FavouriteWebFilm? {
           var favouriteWebFilm: FavouriteWebFilm?
           
            print("FavouriteWebFilm - loadFavourite: trying to read from \(FavouriteWebFilm.archiveURL.path)")
           
           do {
               let fileData = try Data(contentsOf: FavouriteWebFilm.archiveURL.absoluteURL)
               favouriteWebFilm = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(fileData) as? FavouriteWebFilm
           } catch {
               print("didn't work")
           }
           
           return favouriteWebFilm
       }
    
    
}


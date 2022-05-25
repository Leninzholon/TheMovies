//
//  DataManager.swift
//  TheMovies
//
//  Created by apple on 19.05.2022.
//

import Foundation
import RealmSwift

class DataManager{
    static let shared = DataManager()
    var realm = try!Realm()
    var Films : [FilmAddModel] = []

    
    func writeDate(film: FilmAddModel, realm: Realm){
       
        do {
            try realm.write({
                realm.add(film)
            })
        } catch let error{
            print(error)
        }
    }

}

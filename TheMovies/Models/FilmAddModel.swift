//
//  FilmModel.swift
//  TheMovies
//
//  Created by apple on 19.05.2022.
//

import Foundation
import RealmSwift

class FilmAddModel: Object{
    @objc dynamic var backdropPath: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""

}


//
//  FavoriteController.swift
//  TheMovies
//
//  Created by apple on 18.05.2022.
//

import UIKit
import RealmSwift

class FavoriteController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    var films : Results<FilmAddModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.films = DataManager.shared.realm.objects(FilmAddModel.self)
        tableview.register(FavoriteViewCell.nib(), forCellReuseIdentifier: FavoriteViewCell.identifier)
        setLisener()
        setborderTabBar()
    }
    
    func setLisener(){
        NotificationCenter.default.addObserver(self, selector: #selector(reloadRealm), name: .favoriteController, object: nil)
        
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    @objc func reloadRealm(){
        DispatchQueue.main.async {
            self.films = DataManager.shared.realm.objects(FilmAddModel.self)
            self.tableview.reloadData()
        }
    }
    private func setborderTabBar(){
        self.tabBarController!.tabBar.layer.borderWidth = 0.50
        self.tabBarController!.tabBar.layer.borderColor = UIColor.gray.cgColor
        self.tabBarController?.tabBar.clipsToBounds = true
    }
}


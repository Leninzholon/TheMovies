//
//  ViewController.swift
//  TheMovies
//
//  Created by apple on 17.05.2022.
//

import UIKit
import RealmSwift
import Reachability


class PorularFilm: UIViewController {
  
    
    let reachability = try! Reachability()
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    var porularFilms = [Result]()
    var searchText: String?
    var searchResults: [Result] {
        guard let searchText = searchTF.text?.lowercased() else { return [Result]()}
                if searchText.isEmpty {
                    return porularFilms
                } else {
                    return porularFilms.filter { $0.title!.lowercased().contains(searchText)}
                }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        reachability.whenReachable = {[weak self] reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
                NetworkManager.shared.fetchCurrentFilms { [weak self ] films in
                        DispatchQueue.main.async {
                            self?.porularFilms = films!
                            self?.collectionView.reloadData()
                        }
                }
            } else {
                print("Reachable via Cellular")
            }
        }

        reachability.whenUnreachable = {[weak self] _ in
            print("Not reachable")
            self?.showAlert()

        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        setborderTabBar()
        collectionView.register(FillmViewCell.nib(), forCellWithReuseIdentifier: FillmViewCell.identifier)
    }

    func  showAlert(){
        let alert = UIAlertController(title: "no Internet", message: "This App Requires wifi/internet connection!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "FavoriteController") as? FavoriteController else { return }
        controller.films = DataManager.shared.realm.objects(FilmAddModel.self)
    }
    private func setborderTabBar(){
        self.tabBarController!.tabBar.layer.borderWidth = 0.50
        self.tabBarController!.tabBar.layer.borderColor = UIColor.gray.cgColor
        self.tabBarController?.tabBar.clipsToBounds = true
    }
    
}




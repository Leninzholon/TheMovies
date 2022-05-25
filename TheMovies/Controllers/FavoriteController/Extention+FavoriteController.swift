//
//  Extention+FavoriteController.swift
//  TheMovies
//
//  Created by apple on 19.05.2022.
//

import UIKit


extension FavoriteController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteViewCell.identifier, for: indexPath) as? FavoriteViewCell else { return UITableViewCell() }
        cell.configure(with: films[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FavoriteViewCell.height
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
            -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
                let film = self.films[indexPath.row]
                try! DataManager.shared.realm.write({
                    DataManager.shared.realm.delete(film)
                })
                tableView.reloadData()
                completionHandler(true)
            }
            deleteAction.image = UIImage(systemName: "trash")
                deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.0799620077, alpha: 1)
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            return configuration
    }
}

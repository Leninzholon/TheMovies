//
//  Extention+PorularFilms.swift
//  TheMovies
//
//  Created by apple on 17.05.2022.
//

import UIKit
import RealmSwift
//import Reachability

extension PorularFilm: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FillmViewCell.identifier, for: indexPath) as? FillmViewCell else { return UICollectionViewCell() }
        cell.delegate = self
        cell.configure(with: searchResults[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let forVertical: CGFloat = 30
        let forHorizontal: CGFloat = 80
        if view.frame.size.width > view.frame.size.height {
            return CGSize(width: view.frame.size.width / 2 - forHorizontal, height: view.frame.size.width / 2 - forHorizontal)
        }
        return CGSize(width: view.frame.size.width / 2 - forVertical, height: view.frame.size.width / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "PlayerController") as? PlayerController else { return }
        guard let id = porularFilms[indexPath.item].id else { return }
        NetworkManager.shared.fetchCurrentVideo(id: String(id)) { [weak self] id in
            DispatchQueue.main.async {
                controller.urlString = id
                controller.infoData = self?.porularFilms[indexPath.item]
                self?.navigationController?.pushViewController(controller, animated: true)
            }
        }
      
    }
}
extension PorularFilm: FillmViewCellDelegate{
    func favoritePressed(cell: UICollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        let film = porularFilms[indexPath.item]
         let films = DataManager.shared.realm.objects(FilmAddModel.self)
        
        let faviriteFilm: FilmAddModel = FilmAddModel(value: [film.backdropPath!, film.id!, film.title!])
        for item in films{
            if item.backdropPath == faviriteFilm.backdropPath{
                return
            }
        }
        DataManager.shared.writeDate(film: faviriteFilm, realm: DataManager.shared.realm)
        
        collectionView.reloadData()
    }
   
    
}



    
    
      
    
    

extension PorularFilm: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField){
        self.collectionView.reloadData()
    }
}

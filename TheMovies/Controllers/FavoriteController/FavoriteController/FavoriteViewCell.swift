//
//  FavoriteViewCell.swift
//  TheMovies
//
//  Created by apple on 19.05.2022.
//

import UIKit
import Kingfisher

class FavoriteViewCell: UITableViewCell {
    @IBOutlet weak var filmImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    static let height: CGFloat = 150
    static let identifier = "FavoriteViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    static func nib() -> UINib{
        return UINib(nibName: "FavoriteViewCell", bundle: nil)
    }
    func configure(with model: FilmAddModel){
        titleLabel.text = model.title
        guard let url = URL(string: "https://www.themoviedb.org/t/p/original/\(model.backdropPath)") else { return }
        filmImage.kf.indicatorType = .activity
        filmImage.kf.setImage(with: url)
        filmImage.layer.cornerRadius = 5
    }
}

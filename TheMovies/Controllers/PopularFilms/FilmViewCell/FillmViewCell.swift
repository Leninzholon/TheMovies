//
//  FillmViewCell.swift
//  TheMovies
//
//  Created by apple on 17.05.2022.
//

import UIKit
import Kingfisher


protocol FillmViewCellDelegate: AnyObject{
    func favoritePressed(cell: UICollectionViewCell)
}
class FillmViewCell: UICollectionViewCell {
    @IBOutlet weak var filmImage: UIImageView!
    @IBOutlet weak var filmTitle: UILabel!
    static let identifier = "FillmViewCell"
    weak var delegate: FillmViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    static func nib() -> UINib{
        return UINib(nibName: "FillmViewCell", bundle: nil)
    }
    func configure(with model: Result){
        guard let imagePath = model.posterPath else { return }
        setImage(with: imagePath)
        guard let title = model.title else { return }
        filmTitle.text = title
    }
    private func setImage(with link: String){
        guard let url = URL(string: "https://www.themoviedb.org/t/p/original/\(link)") else { return }
        filmImage.kf.indicatorType = .activity
        filmImage.kf.setImage(with: url)
    }
    @IBAction func starClik(_ sender: UIButton) {
        delegate?.favoritePressed(cell: self)
      sender.isSelected = !sender.isSelected
        
    }
}


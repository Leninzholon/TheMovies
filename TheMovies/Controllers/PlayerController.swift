//
//  PlayerController.swift
//  TheMovies
//
//  Created by apple on 18.05.2022.
//

import UIKit
import YouTubeiOSPlayerHelper

class PlayerController: UIViewController {
    @IBOutlet weak var overviewText: UILabel!
    @IBOutlet weak var voteAverage: UILabel!
    @IBOutlet weak var releaseData: UILabel!
    @IBOutlet weak var titleFilm: UILabel!
    @IBOutlet weak var hieghtPlayer: NSLayoutConstraint!
    @IBOutlet var playerView: YTPlayerView!
    var infoData: Result?
    var urlString : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Trailer"
        setVideo()
        setInfo()
    }
    private func setVideo(){
        guard let urlString = urlString else { return }
        
        playerView.load(withVideoId: String(urlString))
    }
    private func setInfo(){
        guard let titleForFilm = infoData?.title else { return }
        guard let releaseFilm = infoData?.releaseDate else { return }
        guard let voteFilm = infoData?.voteAverage else { return }
        guard let overview = infoData?.overview else { return }
        titleFilm.text = titleForFilm
        releaseData.text = releaseFilm
        voteAverage.text = "\(voteFilm)"
        overviewText.text = overview
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if view.frame.size.height > view.frame.size.width{
            hieghtPlayer.constant = view.frame.size.height / 2
        } else {
            hieghtPlayer.constant = view.frame.size.height
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
}

//
//  DetailPresenter.swift
//  MusicApp
//
//  Created by Emre Cambolat on 10.06.2023.
//

import Foundation
import SDWebImage


protocol DetailPresenterProtocol {
    func viewDidload()
    func tapFavorite()
    func setPlayerViewPresenter()
}

final class DetailPresenter{
    unowned var view: DetailViewControllerProtocol
    let router: DetailRouterProctocol!
    
    init(
        view: DetailViewControllerProtocol,
        router: DetailRouterProctocol
    ) {
        self.view = view
        self.router = router
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    func setPlayerViewPresenter() {
        guard let music = view.getMusic else { return }
        guard let audioURL = music.previewURL else { return }
        let presenter = PlayerViewPresenter(view: view.getPlayerView,
                                            audioURL: audioURL,
                                            didPlayMusic: {})
        view.getPlayerView.presenter = presenter
    }
    
    func viewDidload() {
        guard let music = view.getMusic else { return }
        view.setAlbumLabel(music.collectionName ?? "")
        view.setArtistLabel(music.artistName ?? "")
        view.setSongNameLabel(music.trackName ?? "")
        view.setSongTypeLabel(music.primaryGenreName ?? "")
        setPlayerViewPresenter()
        let trackPrice = music.trackPrice ?? 0
        let collectionPrice = music.collectionPrice ?? 0
        view.setTrackPriceLabel(trackPrice == 0 ? "" : String(describing: trackPrice))
        view.setAlbumPriceLabel(collectionPrice == 0 ? "" : String(describing: collectionPrice))
        let songImage = UIImageView()
        let songImageURL = URL(string: music.artworkUrl100 ?? "")
        songImage.sd_setImage(with: songImageURL) {_,_,_,_ in
            self.view.setSongImage(songImage.image)
        }
    }
    
    func tapFavorite() {
        
    }
}

//
//  FavoriteCellPresenter.swift
//  MusicApp
//
//  Created by Emre Cambolat on 16.06.2023.
//

import Foundation
import SDWebImage

// MARK: - Protocols
protocol FavoriteCellPresenterProtocol {
    func load()
    func favoriteImageViewOnTap()
    var didFavoriteTap: ((Int) -> Void)? { get set }
}

final class FavoriteCellPresenter {
    
    // MARK: - Variables
    weak var view: FavoriteCellProtocol?
    private let music: MusicModel
    var didFavoriteTap: ((Int) -> Void)?
    
    init(
        view: FavoriteCellProtocol?,
        music: MusicModel
    ) {
        self.view = view
        self.music = music
    }
}

extension FavoriteCellPresenter: FavoriteCellPresenterProtocol {
    func load() {
        guard let view else { return }
        let songImage = UIImageView()
        let songImageURL = URL(string: music.artworkUrl100 ?? "")
        songImage.sd_setImage(with: songImageURL) {_,_,_,_ in
            self.view?.setImage(songImage.image)
        }
        
        view.setSongName(music.trackName ?? "")
        view.setArtistName(music.artistName ?? "")
        view.setAlbumName(music.collectionName ?? "")
        view.setFavoriteTap()
    }
    
    @objc func favoriteImageViewOnTap() {
        guard let trackID = music.trackID else { return }
        didFavoriteTap?(trackID)
    }
}

//
//  DetailPresenter.swift
//  MusicApp
//
//  Created by Emre Cambolat on 10.06.2023.
//

import SDWebImage
import AudioManager

protocol DetailPresenterProtocol {
    func viewDidLoad()
    func tapFavorite()
    func setPlayerViewPresenter()
    func removeFavorite()
    func stopMusic()
    var getCurrency: String { get }
}

final class DetailPresenter{
    unowned var view: DetailViewControllerProtocol
    let router: DetailRouterProtocol!
    let interactor: DetailInteractorProtocol!
    var favoriteState: FavoriteState = .unFavorite
    
    init(
        view: DetailViewControllerProtocol,
        interactor:DetailInteractorProtocol,
        router: DetailRouterProtocol
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    func stopMusic() {
        AudioManager.shared.stopAudio()
    }
    
    func removeFavorite() {
        guard let musicModel = view.getMusic else { return }
        interactor.deleteModel(with: musicModel.trackID ?? 0)
    }
    
    var getCurrency: String {
        guard let music = view.getMusic,
              let currency = music.currency else { return "" }
        return currency
    }
    
    func setPlayerViewPresenter() {
        guard let music = view.getMusic else { return }
        guard let audioURL = music.previewURL else { return }
        let presenter = PlayerViewPresenter(view: view.getPlayerView,
                                            audioURL: audioURL,
                                            didPlayMusic: {})
        view.getPlayerView.presenter = presenter
    }
    
    func viewDidLoad() {
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
        view.setFavoriteButton()
        interactor.checkIfTrackIdExists(trackID: music.trackID ?? 0)
    }
    
    func tapFavorite() {
        guard let musicModel = view.getMusic else { return }
        switch favoriteState {
        case .favorite:
            view.showRemoveFavoriteAlert()
        case .unFavorite:
            interactor.addModel(musicModel)
        }
    }
}

extension DetailPresenter: DetailInteractorOutputProtocol {
    func modelAddedSuccessfully(_ success: Bool) {
        var message: String
        if success {
            message = "Song added to your favorites"
            favoriteState = .favorite
            view.changeFavoriteState(favoriteState)
        } else {
            message = "There was a problem adding the song to your favorites"
        }
        view.showMessage(message)
    }
    
    func trakcIdExists(_ exists: Bool) {
        if exists {
            favoriteState = .favorite
        } else {
            favoriteState = .unFavorite
        }
        view.changeFavoriteState(favoriteState)
    }
    
    func modelDeletedSuccessfully(_ success: Bool) {
        var message: String
        if success {
            message = "Song removed from your favorites"
            favoriteState = .unFavorite
        } else {
            message = "There was a problem removing the song from your favorites"
            favoriteState = .favorite
        }
        view.changeFavoriteState(favoriteState)
        view.showMessage(message)
    }
}

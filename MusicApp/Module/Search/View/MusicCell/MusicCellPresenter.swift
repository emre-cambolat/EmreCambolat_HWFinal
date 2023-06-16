//
//  MusicCellPresenter.swift
//  MusicApp
//
//  Created by Emre Cambolat on 11.06.2023.
//

import AudioManager
import SDWebImage

// MARK: - Protocols
protocol MusicCellPresenterProtocol: AnyObject {
    func load()
    func setPlayerViewPresenter()
    var audioURL: String { get }
    var trackID: Int { get }
    var didPlayMusic: ((Int) -> Void)? { get set }
}

final class MusicCellPresenter {
    
    // MARK: - Variables
    weak var view: MusicCellProtocol?
    private let music: MusicModel
    var didPlayMusic: ((Int) -> Void)?
    
    init(
        view: MusicCellProtocol?,
        music: MusicModel
    ) {
        self.view = view
        self.music = music
        setPlayerViewPresenter()
    }
}


extension MusicCellPresenter: MusicCellPresenterProtocol {
    func setPlayerViewPresenter() {
        guard let view else { return }
        let presenter = PlayerViewPresenter(view: view.playerView, audioURL: audioURL, didPlayMusic: {
            self.didPlayMusic?(self.trackID)
        })
        view.playerView.presenter = presenter
    }
    
    var audioURL: String {
        guard let url = music.previewURL else { return "" }
        return url
    }
    
    var trackID: Int {
        guard let id = music.trackID else { return 0 }
        return id
    }
    
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
    }
}

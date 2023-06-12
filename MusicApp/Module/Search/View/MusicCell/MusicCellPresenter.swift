//
//  MusicCellPresenter.swift
//  MusicApp
//
//  Created by Emre Cambolat on 11.06.2023.
//

import Foundation
import SDWebImage
import AudioManager

protocol MusicCellPresenterProtocol: AnyObject {
    func load()
    func listenMusic()
}

final class MusicCellPresenter {
    weak var view: MusicCellProtocol?
    private let music: MusicModel
    private var cellState: CellState = .paused
    
    init(
        view: MusicCellProtocol?,
        music: MusicModel
    ) {
        self.view = view
        self.music = music
    }
}


extension MusicCellPresenter: MusicCellPresenterProtocol {
    
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
    
    func listenMusic() {
        switch cellState {
        case .listening:
            cellState = .paused
            AudioManager.shared.stopAudio()
            break
        case .paused:
            guard let audioURL = music.previewURL else { return }
            AudioManager.shared.downloadAndPlayAudio(from: audioURL) {
                self.view?.changeListenButtonState(.paused)
                self.cellState = .paused
            }
            cellState = .listening
        }
        view?.changeListenButtonState(cellState)
    }
}

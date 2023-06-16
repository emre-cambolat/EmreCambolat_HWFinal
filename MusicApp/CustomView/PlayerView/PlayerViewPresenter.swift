//
//  PlayerViewPresenter.swift
//  MusicApp
//
//  Created by Emre Cambolat on 12.06.2023.
//

import AudioManager

protocol PlayerViewPresenterProtocol {
    func listenMusic()
    var playerState: PlayerState { get set }
    var didPlayMusic: (() -> Void) { get set }
}

final class PlayerViewPresenter {
    var playerState: PlayerState = .paused {
        didSet {
            view?.changePlayerState(playerState)
        }
    }
    weak var view: PlayerViewProtocol?
    let audioURL: String
    var didPlayMusic: (() -> Void)
    
    init(view: PlayerViewProtocol,
         audioURL: String,
         didPlayMusic: @escaping (() -> Void)
    ) {
        self.view = view
        self.audioURL = audioURL
        self.didPlayMusic = didPlayMusic
    }
}

extension PlayerViewPresenter: PlayerViewPresenterProtocol {
    func listenMusic() {
        didPlayMusic()
        switch playerState {
        case .listening:
            playerState = .paused
            AudioManager.shared.stopAudio()
        case .paused:
            playerState = .listening
            AudioManager.shared.downloadAndPlayAudio(from: audioURL) {
                self.playerState = .paused
            }
        }
    }
}

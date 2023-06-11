//
//  MusicCellPresenter.swift
//  MusicApp
//
//  Created by Emre Cambolat on 11.06.2023.
//

import Foundation


protocol MusicCellPresenterProtocol: AnyObject {
    func load()
}

final class MusicCellPresenter {
    weak var view: MusicCellProtocol?
    private let music: MusicModel
    
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
        // TODO: setOutlets
    }
}

//
//  DetailInteractor.swift
//  MusicApp
//
//  Created by Emre Cambolat on 10.06.2023.
//

import Foundation


protocol DetailInteractorProtocol {}

protocol DetailInteractorOutputProtocol {
    func fetchMusicDetailOutput(result: MusicModel)
}

final class DetailInteractor {
    var output: SearchInteractorOutputProtocol?
}

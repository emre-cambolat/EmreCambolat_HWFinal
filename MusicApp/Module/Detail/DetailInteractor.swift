//
//  DetailInteractor.swift
//  MusicApp
//
//  Created by Emre Cambolat on 10.06.2023.
//

// MARK: - Protocols
protocol DetailInteractorProtocol {
    func addModel(_ model: MusicModel)
    func checkIfTrackIdExists(trackID: Int)
    func deleteModel(with trackID: Int)
}

protocol DetailInteractorOutputProtocol {
    func modelAddedSuccessfully(_ success: Bool)
    func trakcIdExists(_ exists: Bool)
    func modelDeletedSuccessfully(_ success: Bool)
}

final class DetailInteractor {
    
    // MARK: - Variables
    var output: DetailInteractorOutputProtocol?
    private let favoriteManager = FavoriteManager.shared
}

extension DetailInteractor: DetailInteractorProtocol {
    func addModel(_ model: MusicModel) {
        let success = favoriteManager.addModel(model)
        output?.modelAddedSuccessfully(success)
    }
    
    func checkIfTrackIdExists(trackID: Int) {
        let exists = favoriteManager.checkIfTrackIdExists(trackID: trackID)
        output?.trakcIdExists(exists)
    }
    
    func deleteModel(with trackID: Int) {
        let success = favoriteManager.deleteModel(with: trackID)
        output?.modelDeletedSuccessfully(success)
    }
}

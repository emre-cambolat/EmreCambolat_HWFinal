//
//  FavoriteInteractor.swift
//  MusicApp
//
//  Created by Emre Cambolat on 13.06.2023.
//

// MARK: - Protocols
protocol FavoriteInteractorProtocol: AnyObject {
    func fetchAllModel()
    func deleteModel(with trackID: Int)
    func deleteAllModel()
}

protocol FavoriteInteractorOutputProtocol: AnyObject {
    func fetchAllModelOutput(_ favorites: [MusicModel])
    func modelDeletedSuccessfully(_ success: Bool)
    func allModelDeletedSuccessfully(_ success: Bool)
}

final class FavoriteInteractor {
    
    // MARK: - Variables
    var output: FavoriteInteractorOutputProtocol?
    private let favoriteManager = FavoriteManager.shared
}

extension FavoriteInteractor: FavoriteInteractorProtocol {
    func fetchAllModel() {
        let favorites = favoriteManager.getAllModels
        output?.fetchAllModelOutput(favorites)
    }
    
    func deleteModel(with trackID: Int) {
        let success = favoriteManager.deleteModel(with: trackID)
        output?.modelDeletedSuccessfully(success)
    }
    
    func deleteAllModel() {
        let success = favoriteManager.deleteAllModels()
        output?.allModelDeletedSuccessfully(success)
    }
}

//
//  FavoritePresenter.swift
//  MusicApp
//
//  Created by Emre Cambolat on 13.06.2023.
//

protocol FavoritePresenterProtocol: AnyObject {
    func viewDidLoad()
    func fetchFavories()
    func removeFavorite(with trackID: Int)
    func removeAllFavorite()
    func didSelectRow(at index: Int)
    func favorites(at index: Int) -> MusicModel
    var numberOfItem: Int { get }
    
}

final class FavoritePresenter {
    unowned var view: FavoriteViewProtocol
    let interactor: FavoriteInteractorProtocol
    let router: FavoriteRouterProtocol
    
    private var favorites = [MusicModel]() {
        didSet {
            favorites.isEmpty ?
            view.showEmptyView() :
            view.hideEmptyView()
        }}
    
    init(
        view: FavoriteViewProtocol,
        interactor: FavoriteInteractorProtocol,
        router: FavoriteRouterProtocol
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

extension FavoritePresenter: FavoritePresenterProtocol {
    func fetchFavories() {
        interactor.fetchAllModel()
    }
    
    func viewDidLoad() {
        view.setupTableView()
        view.setEmptyView()
        view.setRemoveAllButton()
        fetchFavories()
    }
    
    func favorites(at index: Int) -> MusicModel { favorites[index] }
    
    func didSelectRow(at index: Int) {
        let source = favorites[index]
        router.navigate(.detail(source: source))
    }
    
    var numberOfItem: Int { favorites.count }
    
    func removeFavorite(with trackID: Int) {
        interactor.deleteModel(with: trackID)
    }
    
    func removeAllFavorite() {
        interactor.deleteAllModel()
    }
}

extension FavoritePresenter: FavoriteInteractorOutputProtocol {
    func fetchAllModelOutput(_ favorites: [MusicModel]) {
        self.favorites.removeAll()
        self.favorites = favorites
        view.reloadTableView()
    }
    
    func modelDeletedSuccessfully(_ success: Bool) {
        if success {
            fetchFavories()
            view.showMessage("Song removed from your favorites")
        } else {
            view.showMessage("There was a problem removing the song from your favorites")
        }
    }
    
    func allModelDeletedSuccessfully(_ success: Bool) {
        if success {
            fetchFavories()
            view.showMessage("All your favorite songs cleared")
        } else {
            view.showMessage("There was a problem deleting your favorite list")
        }
    }
}


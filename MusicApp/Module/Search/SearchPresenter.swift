//
//  SearchPresenter.swift
//  MusicApp
//
//  Created by Emre Cambolat on 10.06.2023.
//

import Foundation

protocol SearchPresenterProtocol: AnyObject {
    func viewDidLoad()
    func fetchMusic(_ term: String)
    func numberOfItem() -> Int
    func music(at index: Int) -> MusicModel?
    func didSelectRowAt(index: Int)
    var searchTimer: Timer? { get set }
    var searchDelay: TimeInterval { get }
}

final class SearchPresenter {
    
    unowned var view: SearchViewControllerProtocol
    let router: SearchRouterProtocol!
    let interactor: SearchInteractorProtocol!
    
    private var musics: [MusicModel]  = []
    var searchTimer: Timer?
    let searchDelay: TimeInterval = 0.3
    
    init(
        view: SearchViewControllerProtocol,
        router: SearchRouterProtocol,
        interactor: SearchInteractorProtocol)
    {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension SearchPresenter: SearchPresenterProtocol {
    func viewDidLoad() {
        view.setupTableView()
    }
    
    func numberOfItem() -> Int { musics.count }
    
    func music(at index: Int) -> MusicModel? { musics[index] }
    
    func didSelectRowAt(index: Int) {
        // TODO:
    }
    
    func fetchMusic(_ term: String) {
        view.showLoadingView()
        interactor.fetchMusic(term)
    }
    
}

extension SearchPresenter: SearchInteractorOutputProtocol {
    func fetchMusicOutput(_ result: Musics?) {
        view.hideLoadingView()
        guard let result else {
            view.showAlert("An error occurred while sending the request")
            return
        }
        musics.removeAll()
        musics = result.results
        view.reloadData()
    }
}

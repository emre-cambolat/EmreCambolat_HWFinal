//
//  SearchPresenter.swift
//  MusicApp
//
//  Created by Emre Cambolat on 10.06.2023.
//

import Foundation
import AudioManager

protocol SearchPresenterProtocol: AnyObject {
    func viewDidLoad()
    func fetchMusic(_ term: String)
    func music(at index: Int) -> MusicModel?
    func didSelectRowAt(index: Int)
    func resetSearch()
    func stopMusic()
    var numberOfItem: Int { get }
    var searchTimer: Timer? { get set }
    var searchDelay: TimeInterval { get }
    var currentListenID: Int { get set }
}

final class SearchPresenter {
    
    unowned var view: SearchViewControllerProtocol
    let router: SearchRouterProtocol!
    let interactor: SearchInteractorProtocol!
    
    private var musics: [MusicModel]  = []
    var searchTimer: Timer?
    let searchDelay: TimeInterval = 0.3
    var currentListenID: Int = 0
    
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
        view.setEmptyView()
    }
    
    func stopMusic() {
        AudioManager.shared.stopAudio()
    }
    
    var numberOfItem: Int { musics.count }
    
    func music(at index: Int) -> MusicModel? { musics[index] }
    
    func didSelectRowAt(index: Int) {
        guard let source = music(at: index) else { return }
        router.navigate(.detail(source: source))
    }
    
    func fetchMusic(_ term: String) {
        guard !term.isEmpty else {
            view.showAlert("Please enter a word")
            return
        }
        currentListenID = 0
        view.showLoadingView()
        interactor.fetchMusic(term)
    }
    
    func resetSearch() {
        musics.removeAll()
        currentListenID = 0
        view.reloadData()
        view.updateEmptyView(.search)
        view.showEmptyView()
    }
    
}

extension SearchPresenter: SearchInteractorOutputProtocol {
    func fetchMusicOutput(_ result: Musics?) {
        view.hideLoadingView()
        guard let result else {
            view.showAlert("An error occurred while sending the request")
            view.updateEmptyView(.noResult)
            view.showEmptyView()
            return
        }
        musics.removeAll()
        musics = result.results
        view.reloadData()
        if musics.isEmpty {
            view.updateEmptyView(.noResult)
            view.showEmptyView()
        } else {
            view.hideEmptyView()
        }
    }
}

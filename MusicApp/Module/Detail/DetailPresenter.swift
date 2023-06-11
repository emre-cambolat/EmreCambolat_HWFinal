//
//  DetailPresenter.swift
//  MusicApp
//
//  Created by Emre Cambolat on 10.06.2023.
//

import Foundation


protocol DetailPresenterProtocol {
    func viewDidload()
    func tapFavorite()
}

final class DetailPresenter{
    unowned var view: DetailViewControllerProtocol
    let router: DetailRouterProctocol!
    
    init(
        view: DetailViewControllerProtocol,
        router: DetailRouterProctocol
    ) {
        self.view = view
        self.router = router
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    func viewDidload() {
        guard let music = view.getSource() else { return }
        // TODO: setOutlets
    }
    
    func tapFavorite() {
        
    }
    
    
}

//
//  DetailRouter.swift
//  MusicApp
//
//  Created by Emre Cambolat on 10.06.2023.
//

import Foundation

protocol DetailRouterProctocol {
    func navigate(_ route: DetailRoutes)
}

enum DetailRoutes {
    case pop
}

final class DetailRouter{
    weak var viewController: DetailViewController?
    
    static func createModule() -> DetailViewController {
        let view = DetailViewController()
        let router = DetailRouter()
        let presenter = DetailPresenter(view: view, router: router)
        view.presenter = presenter
        router.viewController = view
        return view
    }
}

extension DetailRouter: DetailRouterProctocol {
    func navigate(_ route: DetailRoutes) {
        switch route {
        case .pop:
            viewController?.navigationController?.popViewController(animated: true)
        }
    }
}

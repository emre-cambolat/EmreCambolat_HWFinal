//
//  DetailRouter.swift
//  MusicApp
//
//  Created by Emre Cambolat on 10.06.2023.
//

protocol DetailRouterProtocol {
    func navigate(_ route: DetailRoutes)
}

enum DetailRoutes {
    case pop
}

final class DetailRouter{
    weak var viewController: DetailViewController?
    
    static func createModule() -> DetailViewController {
        let view = DetailViewController()
        let interactor = DetailInteractor()
        let router = DetailRouter()
        let presenter = DetailPresenter(view: view,
                                        interactor: interactor,
                                        router: router)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
}

extension DetailRouter: DetailRouterProtocol {
    func navigate(_ route: DetailRoutes) {
        switch route {
        case .pop:
            viewController?.navigationController?.popViewController(animated: true)
        }
    }
}

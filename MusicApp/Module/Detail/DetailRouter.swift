//
//  DetailRouter.swift
//  MusicApp
//
//  Created by Emre Cambolat on 10.06.2023.
//

// MARK: - Protocols
protocol DetailRouterProtocol {
    func navigate(_ route: DetailRoutes)
}

enum DetailRoutes {
    case pop
}

final class DetailRouter{
    
    // MARK: - Variables
    weak var viewController: DetailViewController?
    
    // MARK: - Functions
    static func createModule() -> DetailViewController {
        let view = DetailViewController()
        let interactor = DetailInteractor()
        let router = DetailRouter()
        let presenter = DetailPresenter(
            view: view,
            interactor: interactor,
            router: router
        )
        
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

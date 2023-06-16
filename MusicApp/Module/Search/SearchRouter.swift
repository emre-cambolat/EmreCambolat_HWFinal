//
//  SearchRouter.swift
//  MusicApp
//
//  Created by Emre Cambolat on 10.06.2023.
//

// MARK: - Protocols
protocol SearchRouterProtocol {
    func navigate(_ route: SearchRoutes)
}

enum SearchRoutes {
    case detail(source: MusicModel)
}

final class SearchRouter {
    
    // MARK: - Variables
    weak var viewController: SearchViewController?
    
    // MARK: - Functions
    static func createModule() -> SearchViewController {
        let view = SearchViewController()
        let interactor = SearchInteractor()
        let router = SearchRouter()
        let presenter = SearchPresenter(
            view: view,
            router: router,
            interactor: interactor
        )
        
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
}

extension SearchRouter: SearchRouterProtocol {
    func navigate(_ route: SearchRoutes) {
        switch route {
        case .detail(let source):
            let detailVC = DetailRouter.createModule()
            detailVC.source = source
            viewController?.navigationController?.pushViewController(detailVC, animated: true)
            break
        }
    }
}

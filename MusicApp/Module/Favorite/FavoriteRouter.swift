//
//  FavoriteRouter.swift
//  MusicApp
//
//  Created by Emre Cambolat on 13.06.2023.
//

protocol FavoriteRouterProtocol: AnyObject {
    func navigate(_ route: FavoriteRoutes)
}

enum FavoriteRoutes {
    case pop
    case detail(source: MusicModel)
}

final class FavoriteRouter {
    weak var viewController: FavoriteViewController?
    
    static func createModule() -> FavoriteViewController {
        let view = FavoriteViewController()
        let interactor = FavoriteInteractor()
        let router = FavoriteRouter()
        let presenter = FavoritePresenter(view: view,
                                        interactor: interactor,
                                        router: router)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
}

extension FavoriteRouter: FavoriteRouterProtocol {
    func navigate(_ route: FavoriteRoutes) {
        switch route {
        case .pop:
            viewController?.navigationController?.popViewController(animated: true)
        case .detail(let source):
            let detailVC = DetailRouter.createModule()
            detailVC.source = source
            viewController?.navigationController?.pushViewController(detailVC, animated: true)
            break
        }
    }
}

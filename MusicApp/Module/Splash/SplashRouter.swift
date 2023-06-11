//
//  SplashRouter.swift
//  MusicApp
//
//  Created by Emre Cambolat on 10.06.2023.
//

import Foundation
import UIKit

enum SplashRoute {
    case searchScreen
}

protocol SplashRouterProtocol: AnyObject {
    func navigate(_ route: SplashRoute)
}

final class SplashRouter {
    weak var viewController: SplashViewController?
    
    static func createModule() -> SplashViewController {
        let view = SplashViewController()
        let interactor = SplashInteractor()
        let router = SplashRouter()
        let presenter = SplashPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
}

extension SplashRouter: SplashRouterProtocol {
    func navigate(_ route: SplashRoute) {
        switch route {
        case .searchScreen:
            guard let window = viewController?.view.window else { return }
            let searchVC = SearchRouter.createModule()
            let navigateController = UINavigationController(rootViewController: searchVC)
            window.rootViewController = navigateController
        }
    }
}

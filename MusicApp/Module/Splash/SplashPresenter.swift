//
//  SplashPresenter.swift
//  MusicApp
//
//  Created by Emre Cambolat on 10.06.2023.
//

import Foundation

// MARK: - Protools
protocol SplashPresenterProtocol: AnyObject {
    func viewDidAppear()
}

final class SplashPresenter: SplashPresenterProtocol {
    
    // MARK: - Variables
    unowned var view: SplashViewControllerProtocol!
    let router: SplashRouterProtocol!
    let interactor: SplashInteractorProtocol!
    
    init(
        view: SplashViewControllerProtocol,
        router: SplashRouterProtocol,
        interactor: SplashInteractorProtocol)
    {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidAppear() {
        interactor.checkInternetConnection()
    }
}

extension SplashPresenter: SplashInteractorOutputProtocol {
    func internetConnection(status: Bool) {
        if status {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.router.navigate(.searchScreen)
            }
        } else {
            view.showAlert()
        }
    }
}

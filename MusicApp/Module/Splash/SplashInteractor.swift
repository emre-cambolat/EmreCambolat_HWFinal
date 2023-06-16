//
//  SplashInteractor.swift
//  MusicApp
//
//  Created by Emre Cambolat on 10.06.2023.
//

import NetworkManager

// MARK: - Protocols
protocol SplashInteractorProtocol {
    func checkInternetConnection()
}

protocol SplashInteractorOutputProtocol {
    func internetConnection(status: Bool)
}

final class SplashInteractor {
    
    // MARK: - Variables
    var output: SplashInteractorOutputProtocol?
}

extension SplashInteractor: SplashInteractorProtocol {
    func checkInternetConnection() {
        let internetStatus = NetworkManager.shared.isInternetAvailable()
        self.output?.internetConnection(status: internetStatus)
    }
}

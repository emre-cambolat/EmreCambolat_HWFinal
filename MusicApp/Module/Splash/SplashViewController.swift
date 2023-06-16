//
//  SplashViewController.swift
//  MusicApp
//
//  Created by Emre Cambolat on 10.06.2023.
//

import UIKit

// MARK: - Protocols
protocol SplashViewControllerProtocol: AnyObject {
    func showAlert()
}

final class SplashViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var alertStackView: UIStackView!
    
    // MARK: - Variables
    var presenter: SplashPresenterProtocol!
    
    // MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidAppear()
    }
    
    // MARK: - IBActions
    @IBAction private func checkInternetConnection(_ sender: Any) {
        presenter.viewDidAppear()
    }
}

extension SplashViewController: SplashViewControllerProtocol {
    func showAlert() {
        DispatchQueue.main.async {
            self.alertStackView.isHidden = false
        }
    }
}

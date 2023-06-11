//
//  SplashViewController.swift
//  MusicApp
//
//  Created by Emre Cambolat on 10.06.2023.
//

import UIKit

protocol SplashViewControllerProtocol: AnyObject {
    func showAlert()
}

final class SplashViewController: UIViewController {
    
    @IBOutlet private weak var alertStackView: UIStackView!
    
    
    var presenter: SplashPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidAppear()
    }
    
    @IBAction private func checkInternetConnection(_ sender: Any) {
        presenter.viewDidAppear()
        print("Internet kontrol edildi")
    }
}

extension SplashViewController: SplashViewControllerProtocol {
    func showAlert() {
        DispatchQueue.main.async {
            self.alertStackView.isHidden = false
        }
    }
}

//
//  DetailViewController.swift
//  MusicApp
//
//  Created by Emre Cambolat on 10.06.2023.
//

import UIKit

protocol DetailViewControllerProtocol: AnyObject {
    func getSource() -> MusicModel?
}

final class DetailViewController: UIViewController {
    
    var presenter: DetailPresenterProtocol!
    var source: MusicModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidload()
    }

}

extension DetailViewController: DetailViewControllerProtocol {
    func getSource() -> MusicModel? {
        return nil
    }
}

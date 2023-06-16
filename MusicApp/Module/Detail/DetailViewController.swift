//
//  DetailViewController.swift
//  MusicApp
//
//  Created by Emre Cambolat on 10.06.2023.
//

import UIKit

// MARK: - Protocols
protocol DetailViewControllerProtocol: AnyObject {
    var getMusic: MusicModel? { get }
    var getPlayerView: PlayerView { get }
    func setSongImage(_ image: UIImage?)
    func setArtistLabel(_ text: String)
    func setAlbumLabel(_ text: String)
    func setSongNameLabel(_ text: String)
    func setSongTypeLabel(_ text: String)
    func setTrackPriceLabel(_ text: String)
    func setAlbumPriceLabel(_ text: String)
    func changeFavoriteState(_ state: FavoriteState)
    func setFavoriteButton()
    func showMessage(_ message: String)
    func showRemoveFavoriteAlert()
}

enum FavoriteState {
    case favorite
    case unFavorite
}

final class DetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var songImage: UIImageView!
    @IBOutlet private weak var artistLabel: UILabel!
    @IBOutlet private weak var albumLabel: UILabel!
    @IBOutlet private weak var playerView: PlayerView!
    @IBOutlet private weak var songNameLabel: UILabel!
    @IBOutlet private weak var songTypeLabel: UILabel!
    @IBOutlet private weak var trackPriceLabel: UILabel!
    @IBOutlet private weak var albumPriceLabel: UILabel!
    
    // MARK: - Variables
    var presenter: DetailPresenterProtocol!
    var source: MusicModel?
    private var favoriteButton: UIBarButtonItem?
    
    // MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        presenter.stopMusic()
    }
    
    // MARK: - Functions
    @objc func favoriteButtonTap() {
        presenter.tapFavorite()
    }
}

extension DetailViewController: DetailViewControllerProtocol {
    
    func showMessage(_ message: String) { showToast(message) }
    
    func showRemoveFavoriteAlert() {
        let alertController = UIAlertController(title: "Are you sure?", message: "This song will be removed from your favorites", preferredStyle: .alert)
        
        let removeAction = UIAlertAction(title: "Remove", style: .destructive) { (action) in
            self.presenter.removeFavorite()
        }
        removeAction.isAccessibilityElement = true
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        cancelAction.isAccessibilityElement = true
        
        alertController.addAction(removeAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    var getPlayerView: PlayerView { playerView }
    
    var getMusic: MusicModel? { source }
    
    func setSongImage(_ image: UIImage?) {
        DispatchQueue.main.async {
            self.songImage.image = image
        }
    }
    
    func setArtistLabel(_ text: String) {
        artistLabel.text = text
    }
    
    func setAlbumLabel(_ text: String) {
        albumLabel.text = text
    }
    
    func setSongNameLabel(_ text: String) {
        songNameLabel.text = text
    }
    
    func setSongTypeLabel(_ text: String) {
        songTypeLabel.text = text
    }
    
    func setTrackPriceLabel(_ text: String) {
        if text.isEmpty {
            trackPriceLabel.isHidden = true
            return
        }
        let currency = presenter.getCurrency
        trackPriceLabel.text = "Track Rrice: \(text) \(currency)"
    }
    
    func setAlbumPriceLabel(_ text: String) {
        if text.isEmpty {
            albumPriceLabel.isHidden = true
        } else {
            let currency = presenter.getCurrency
            albumPriceLabel.text = "Collection Price: \(text) \(currency)"
        }
    }
    
    func changeFavoriteState(_ state: FavoriteState) {
        var imageName: String
        switch state {
        case .favorite:
            imageName = "star.fill"
        case .unFavorite:
            imageName = "star"
        }
        favoriteButton?.image = UIImage(systemName: imageName)
    }
    
    func setFavoriteButton() {
        favoriteButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favoriteButtonTap))
        navigationItem.rightBarButtonItem = favoriteButton
    }
}

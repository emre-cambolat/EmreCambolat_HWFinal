//
//  DetailViewController.swift
//  MusicApp
//
//  Created by Emre Cambolat on 10.06.2023.
//

import UIKit

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
}

final class DetailViewController: UIViewController {
    
    @IBOutlet private weak var songImage: UIImageView!
    @IBOutlet private weak var artistLabel: UILabel!
    @IBOutlet private weak var albumLabel: UILabel!
    @IBOutlet private weak var playerView: PlayerView!
    @IBOutlet private weak var songNameLabel: UILabel!
    @IBOutlet private weak var songTypeLabel: UILabel!
    @IBOutlet private weak var trackPriceLabel: UILabel!
    @IBOutlet private weak var albumPriceLabel: UILabel!
    
    var presenter: DetailPresenterProtocol!
    var source: MusicModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidload()
        
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: "play"), style: .plain, target: self, action: #selector(settingsButtonTapped))
            navigationItem.rightBarButtonItem = settingsButton
        
        navigationItem.rightBarButtonItem = settingsButton
    }
    
    @objc func settingsButtonTapped() {
        print("Kaçaoouuvvvvv")
    }

}

extension DetailViewController: DetailViewControllerProtocol {
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
        trackPriceLabel.text = "Track Rrice: \(text)"
    }
    
    func setAlbumPriceLabel(_ text: String) {
        if text.isEmpty {
            albumPriceLabel.isHidden = true
            return
        }
        albumPriceLabel.text = "Collection Price: \(text)"
    }
}

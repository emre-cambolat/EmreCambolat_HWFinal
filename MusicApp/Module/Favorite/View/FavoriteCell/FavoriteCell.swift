//
//  FavoriteCell.swift
//  MusicApp
//
//  Created by Emre Cambolat on 15.06.2023.
//

import UIKit

// MARK: - Protocols
protocol FavoriteCellProtocol: AnyObject {
    func setImage(_ image: UIImage?)
    func setSongName(_ text: String)
    func setArtistName(_ text: String)
    func setAlbumName(_ text: String)
    func setFavoriteTap()
}

class FavoriteCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var songAlbumLabel: UILabel!
    @IBOutlet private weak var songArtistLabel: UILabel!
    @IBOutlet private weak var songNameLabel: UILabel!
    @IBOutlet private weak var songImage: UIImageView!
    @IBOutlet private weak var favoriteImageView: UIView!
    
    // MARK: - Variables
    var cellPresenter: FavoriteCellPresenterProtocol!{
        didSet {
            cellPresenter.load()
        }
    }
    
    // MARK: - Override Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isAccessibilityElement = true
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension FavoriteCell: FavoriteCellProtocol {
    func setFavoriteTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(favoriteOnTap))
        tapGesture.isAccessibilityElement = true
        favoriteImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func favoriteOnTap() {
        cellPresenter.favoriteImageViewOnTap()
    }
    
    func setImage(_ image: UIImage?) {
        DispatchQueue.main.async {
            self.songImage.image = image
        }
    }
    
    func setSongName(_ text: String) {
        songNameLabel.text = text
    }
    
    func setArtistName(_ text: String) {
        songArtistLabel.text = text
    }
    
    func setAlbumName(_ text: String) {
        songAlbumLabel.text = text
    }
}

//
//  MusicCell.swift
//  MusicApp
//
//  Created by Emre Cambolat on 11.06.2023.
//

import UIKit

protocol MusicCellProtocol: AnyObject {
    func setImage(_ image: UIImage?)
    func setSongName(_ text: String)
    func setArtistName(_ text: String)
    func setAlbumName(_ text: String)
    func resetCell()
    var playerView: PlayerView { get }
}

final class MusicCell: UITableViewCell {
    
    @IBOutlet private weak var listenButtonView: PlayerView!
    @IBOutlet private weak var songAlbumLabel: UILabel!
    @IBOutlet private weak var songArtistLabel: UILabel!
    @IBOutlet private weak var songNameLabel: UILabel!
    @IBOutlet private weak var songImage: UIImageView!
    
    var cellPresenter: MusicCellPresenterProtocol!{
        didSet {
            cellPresenter.load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isAccessibilityElement = true
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


extension MusicCell: MusicCellProtocol {
    var playerView: PlayerView { listenButtonView }
    
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
    func resetCell() {
        songImage.image = nil
        playerView.changePlayerState(.paused)
    }
}

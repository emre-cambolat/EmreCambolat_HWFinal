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
    func changeListenButtonState(_ state: CellState)
}

enum CellState {
    case listening
    case paused
}

final class MusicCell: UITableViewCell {
    

    @IBOutlet weak var listenButtonView: UIView!
    @IBOutlet weak var listenImageView: UIImageView!
    @IBOutlet weak var songAlbumLabel: UILabel!
    @IBOutlet weak var songArtistLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var songImage: UIImageView!

    var cellPresenter: MusicCellPresenterProtocol!{
        didSet {
            cellPresenter.load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setListenButton()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setListenButton() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(listenMusicOnTap))
        listenButtonView.addGestureRecognizer(tapGesture)
    }
    
    @objc func listenMusicOnTap() {        cellPresenter.listenMusic()
    }
}


extension MusicCell: MusicCellProtocol {
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
    
    func changeListenButtonState(_ state: CellState) {
        var imageName: String
        switch state {
        case .listening:
            imageName = "pause.circle"
        case .paused:
            imageName = "play.circle"
        }
        DispatchQueue.main.async {
            self.listenImageView.image = UIImage(systemName: imageName)
        }
    }
}

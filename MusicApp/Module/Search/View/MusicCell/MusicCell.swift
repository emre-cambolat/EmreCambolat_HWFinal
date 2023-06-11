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
    

    @IBOutlet weak var listenMusicButton: UIButton!
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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func listenMusicButtonClick(_ sender: Any) {
//        self.listenMusicButton.setImage(UIImage(named: "pause.circle"), for: .normal)
        listenMusicButton.setBackgroundImage(UIImage(named: "pause.circle"), for: .normal)

        cellPresenter.listenMusic()
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
            self.listenMusicButton.setImage(UIImage(named: imageName), for: .application)
        }
    }
}

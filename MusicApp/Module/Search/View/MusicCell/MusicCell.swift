//
//  MusicCell.swift
//  MusicApp
//
//  Created by Emre Cambolat on 11.06.2023.
//

import UIKit

protocol MusicCellProtocol: AnyObject {
    func setImage(_ image: UIImage)
    func setSongName(_ text: String)
    func setArtistName(_ text: String)
    func setAlbumName(_ text: String)
    func changeListenButtonState()
}

final class MusicCell: UITableViewCell {
    

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
    
    func setup(_ model: MusicModel) {

    }
    
    @IBAction func listenMusic(_ sender: Any) {
        
    }
}

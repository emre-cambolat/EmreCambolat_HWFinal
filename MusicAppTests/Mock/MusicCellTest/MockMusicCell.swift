//
//  MockMusicCell.swift
//  MusicAppTests
//
//  Created by Emre Cambolat on 16.06.2023.
//

import UIKit
@testable import MusicApp

final class MockMusicCell: MusicCellProtocol {
    
    var isInvokedSetImage = false
    var invokedSetImageCount = 0
    var invokedSetImageParameters: (image: UIImage, Void)?
    
    func setImage(_ image: UIImage?) {
        isInvokedSetImage = true
        invokedSetImageCount += 1
        invokedSetImageParameters = (image ?? UIImage(), ())
    }
    
    var isInvokedSetSongName = false
    var invokedSetSongNameCount = 0
    var invokedSetSongNameParameters: (text: String, Void)?
    
    func setSongName(_ text: String) {
        isInvokedSetSongName = true
        invokedSetSongNameCount += 1
        invokedSetSongNameParameters = (text, ())
    }
    
    var isInvokedSetArtistName = false
    var invokedSetArtistNameCount = 0
    var invokedSetArtistNameParameters: (text: String, Void)?
    
    func setArtistName(_ text: String) {
        isInvokedSetArtistName = true
        invokedSetArtistNameCount += 1
        invokedSetArtistNameParameters = (text, ())
    }
    
    var isInvokedSetAlbumName = false
    var invokedSetAlbumNameCount = 0
    var invokedSetAlbumNameParameters: (text: String, Void)?
    
    func setAlbumName(_ text: String) {
        isInvokedSetAlbumName = true
        invokedSetAlbumNameCount += 1
        invokedSetAlbumNameParameters = (text, ())
    }
    
    var isInvokedResetCell = false
    var invokedResetCellCount = 0
    
    func resetCell() {
        isInvokedResetCell = true
        invokedResetCellCount += 1
    }
    
    var playerView: PlayerView
    
    init(playerView: PlayerView) {
        self.playerView = playerView
    }
}

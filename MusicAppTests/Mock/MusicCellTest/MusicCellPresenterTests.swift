//
//  MusicCellPresenterTests.swift
//  MusicAppTests
//
//  Created by Emre Cambolat on 16.06.2023.
//

import XCTest
@testable import MusicApp

final class MusicCellPresenterTests: XCTestCase {
    
    var view: MockMusicCell!
    var music: MusicModel!
    var presenter: MusicCellPresenter!
//    var playerView: PlayerView!
    
    
    override func setUp() {
        super.setUp()
       
        let playerView = PlayerView()
        
        view = .init(playerView: playerView)
        let playerViewPresenter = PlayerViewPresenter(view: view.playerView, audioURL: "", didPlayMusic: {})
        playerView.presenter = playerViewPresenter
        let musicModel = MusicModel(
            collectionID: 2023,
            trackID: 3,
            artistName: "Kerim Çağlar",
            collectionName: "TGY 2023",
            trackName: "Son Bir Şarkı",
            previewURL: "",
            artworkUrl100: "",
            collectionPrice: 1.99,
            trackPrice: 12.99,
            primaryGenreName: "Turkish Rock",
            currency: "USD"
        )
        presenter = .init(view: view, music: musicModel)
    }
    
    override func tearDown() {
        super.tearDown()
        view = nil
        music = nil
        presenter = nil
    }
    
    func test_SetImage() {
        XCTAssertFalse(view.isInvokedSetImage)
        XCTAssertEqual(view.invokedSetImageCount, 0)
        
        let image = UIImage(systemName: "gear")
        view.setImage(image)
        
        XCTAssertTrue(view.isInvokedSetImage)
        XCTAssertEqual(view.invokedSetImageCount, 1)
        XCTAssertEqual(view.invokedSetImageParameters?.image, image)
    }
    
    func test_SetSongName() {
        XCTAssertFalse(view.isInvokedSetSongName)
        XCTAssertEqual(view.invokedSetSongNameCount, 0)
        
        let songName = "Example Song"
        view.setSongName(songName)
        
        XCTAssertTrue(view.isInvokedSetSongName)
        XCTAssertEqual(view.invokedSetSongNameCount, 1)
        XCTAssertEqual(view.invokedSetSongNameParameters?.text, songName)
    }
    
    func test_SetArtistName() {
        XCTAssertFalse(view.isInvokedSetArtistName)
        XCTAssertEqual(view.invokedSetArtistNameCount, 0)
        
        let artistName = "Example Artist"
        view.setArtistName(artistName)
        
        XCTAssertTrue(view.isInvokedSetArtistName)
        XCTAssertEqual(view.invokedSetArtistNameCount, 1)
        XCTAssertEqual(view.invokedSetArtistNameParameters?.text, artistName)
    }
    
    func test_SetAlbumName() {
        XCTAssertFalse(view.isInvokedSetAlbumName)
        XCTAssertEqual(view.invokedSetAlbumNameCount, 0)
        
        let albumName = "Example Album"
        view.setAlbumName(albumName)
        
        XCTAssertTrue(view.isInvokedSetAlbumName)
        XCTAssertEqual(view.invokedSetAlbumNameCount, 1)
        XCTAssertEqual(view.invokedSetAlbumNameParameters?.text, albumName)
    }
    
    func test_ResetCell() {
        XCTAssertFalse(view.isInvokedResetCell)
        XCTAssertEqual(view.invokedResetCellCount, 0)
        
        view.resetCell()
        
        XCTAssertTrue(view.isInvokedResetCell)
        XCTAssertEqual(view.invokedResetCellCount, 1)
    }
    
}

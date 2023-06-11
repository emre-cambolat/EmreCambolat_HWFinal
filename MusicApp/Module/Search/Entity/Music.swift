//
//  Music.swift
//  MusicApp
//
//  Created by Emre Cambolat on 10.06.2023.
//

import Foundation

// MARK: - Musics
struct Musics: Codable {
    let resultCount: Int
    let results: [MusicModel]
}

// MARK: - MusicModel
struct MusicModel: Codable {
    let artistID, collectionID, trackID: Int?
    let artistName: String?
    let collectionName, trackName, collectionCensoredName, trackCensoredName: String?
    let artistViewURL, collectionViewURL, trackViewURL: String?
    let previewURL: String?
    let artworkUrl30, artworkUrl60, artworkUrl100: String?
    let collectionPrice, trackPrice: Double?
    let releaseDate: String?
    let collectionExplicitness, trackExplicitness: String?
    let discCount, discNumber, trackCount, trackNumber: Int?
    let trackTimeMillis: Int?
    let primaryGenreName: String?
    let isStreamable: Bool?
    let contentAdvisoryRating: String?
    let collectionArtistID: Int?
    let collectionArtistName: String?

    enum CodingKeys: String, CodingKey {
        case artistID = "artistId"
        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName, collectionName, trackName, collectionCensoredName, trackCensoredName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, releaseDate, collectionExplicitness, trackExplicitness, discCount, discNumber, trackCount, trackNumber, trackTimeMillis, primaryGenreName, isStreamable, contentAdvisoryRating
        case collectionArtistID = "collectionArtistId"
        case collectionArtistName
    }
}


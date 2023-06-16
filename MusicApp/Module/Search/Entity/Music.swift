//
//  Music.swift
//  MusicApp
//
//  Created by Emre Cambolat on 10.06.2023.
//

// MARK: - Musics
struct Musics: Decodable {
    let resultCount: Int
    let results: [MusicModel]
}

// MARK: - MusicModel
struct MusicModel: Decodable {
    let collectionID, trackID: Int?
    let artistName: String?
    let collectionName, trackName: String?
    let previewURL: String?
    let artworkUrl100: String?
    let collectionPrice, trackPrice: Double?
    let primaryGenreName: String?
    let currency: String?

    enum CodingKeys: String, CodingKey {
        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName, collectionName, trackName
        case previewURL = "previewUrl"
        case artworkUrl100, collectionPrice, trackPrice, primaryGenreName
        case currency
    }
}


//
//  SearchInteractor.swift
//  MusicApp
//
//  Created by Emre Cambolat on 10.06.2023.
//

import Foundation
import Alamofire

protocol SearchInteractorProtocol: AnyObject {
    func fetchMusic(_ term: String)
}

protocol SearchInteractorOutputProtocol {
    func fetchMusicOutput(_ result: Musics?)
}

final class SearchInteractor {
    var output: SearchInteractorOutputProtocol?
}

extension SearchInteractor: SearchInteractorProtocol {
    func fetchMusic(_ term: String) {
        let url = "https://itunes.apple.com/search?media=music&term=\(term)"
        AF.request(url).responseDecodable(of: Musics.self) { [weak self] response in
            guard let self else { return }
            switch response.result {
            case .success(let posts):
                self.output?.fetchMusicOutput(posts)
            case .failure(let error):
                print("****", error)
//                self.errorMessage()
//                delegate?.hideLoadingView()
            }
        }
    }
}

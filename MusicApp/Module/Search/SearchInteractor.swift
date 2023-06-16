//
//  SearchInteractor.swift
//  MusicApp
//
//  Created by Emre Cambolat on 10.06.2023.
//

import Alamofire

// MARK: - Protocols
protocol SearchInteractorProtocol: AnyObject {
    func fetchMusic(_ term: String)
}

protocol SearchInteractorOutputProtocol {
    func fetchMusicOutput(_ result: Musics?)
}

final class SearchInteractor {
    
    // MARK: - Variables
    var output: SearchInteractorOutputProtocol?
}

extension SearchInteractor: SearchInteractorProtocol {
    func fetchMusic(_ term: String) {
        if let encodedTerm = term.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let url = "https://itunes.apple.com/search?media=music&term=\(encodedTerm)"
            AF.request(url).responseDecodable(of: Musics.self) { [weak self] response in
                guard let self = self else { return }
                switch response.result {
                case .success(let posts):
                    self.output?.fetchMusicOutput(posts)
                case .failure(let error):
                    print("****", error)
                    self.output?.fetchMusicOutput(nil)
                }
            }
        } else {
            print("Invalid search term")
            self.output?.fetchMusicOutput(nil)
        }
    }
}

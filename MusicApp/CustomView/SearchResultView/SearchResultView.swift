//
//  SearchResultView.swift
//  MusicApp
//
//  Created by Emre Cambolat on 13.06.2023.
//

import UIKit

enum SearchResultViewType {
    case search
    case noResult
}

protocol SearchResultViewProtocol: AnyObject {
    func changeType(_ type: SearchResultViewType)
    func setOutlets(image: String, content: String)
}

final class SearchResultView: UIView {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var contentLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        let bundle = String(describing: SearchResultView.self)
        if let view = Bundle.main.loadNibNamed(bundle, owner: self, options: nil)?.first as? UIView {
            addSubview(view)
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
    
}

extension SearchResultView: SearchResultViewProtocol {
    func changeType(_ type: SearchResultViewType) {
        var imagePath: String
        var contentMessage: String
        switch type {
        case .search:
            imagePath = "search_bg"
            contentMessage = "Search for music"
        case .noResult:
            imagePath = "no_result_bg"
            contentMessage = "No result found"
        }
        
        setOutlets(image: imagePath, content: contentMessage)
    }
    
    func setOutlets(image: String, content: String){
        DispatchQueue.main.async {
            self.imageView.image = UIImage(named: image)
            self.contentLabel.text = content
        }
    }
}

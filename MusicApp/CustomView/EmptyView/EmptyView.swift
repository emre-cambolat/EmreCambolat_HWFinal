//
//  EmptyView.swift
//  MusicApp
//
//  Created by Emre Cambolat on 13.06.2023.
//

import UIKit

enum EmptyViewType {
    case search
    case noResult
    case addFavorite
}

protocol EmptyViewProtocol: AnyObject {
    func changeType(_ type: EmptyViewType)
    func setOutlets(image: String, content: String)
}

final class EmptyView: UIView {

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
        let bundle = String(describing: EmptyView.self)
        if let view = Bundle.main.loadNibNamed(bundle, owner: self, options: nil)?.first as? UIView {
            addSubview(view)
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
        self.isAccessibilityElement = true
    }
    
}

extension EmptyView: EmptyViewProtocol {
    func changeType(_ type: EmptyViewType) {
        var imagePath: String
        var contentMessage: String
        switch type {
        case .search:
            imagePath = "search_bg"
            contentMessage = "Search for music"
        case .noResult:
            imagePath = "no_result_bg"
            contentMessage = "No result found"
        case .addFavorite:
            imagePath = "favorite_bg"
            contentMessage = "Add songs as favorites"
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

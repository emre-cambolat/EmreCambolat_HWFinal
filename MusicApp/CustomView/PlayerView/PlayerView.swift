//
//  PlayerView.swift
//  MusicApp
//
//  Created by Emre Cambolat on 12.06.2023.
//

import UIKit

// MARK: - Protocols
protocol PlayerViewProtocol: AnyObject {
    func changePlayerState(_ state: PlayerState)
    func setImage(_ image: UIImage)
}

enum PlayerState {
    case listening
    case paused
}

final class PlayerView: UIView {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private var onTapView: UITapGestureRecognizer!
    
    // MARK: - Variables
    private let nibName = String(describing: PlayerView.self)
    private var contentView:UIView?
    var presenter: PlayerViewPresenterProtocol!
    
    // MARK: - Override Functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Functions
    private func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
        self.isAccessibilityElement = true
        onTapView.isAccessibilityElement = true
    }
    
    private func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    // MARK: - IBActions
    @IBAction func onTap(_ sender: Any) {
        presenter.listenMusic()
    }
}

extension PlayerView: PlayerViewProtocol {
    func changePlayerState(_ state: PlayerState) {
        var imageName: String
        switch state {
        case .listening:
            imageName = "pause.circle"
        case .paused:
            imageName = "play.circle"
        }
        setImage(UIImage(systemName: imageName)!)
    }
    
    func setImage(_ image: UIImage) {
        self.imageView.image = image
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
}

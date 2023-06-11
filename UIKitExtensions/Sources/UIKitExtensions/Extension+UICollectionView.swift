//
//  Extension+UICollectionView.swift
//  DictionaryApp
//
//  Created by Emre Cambolat on 30.05.2023.
//

import UIKit

public extension UICollectionView {
    func registerCollectionCell<T: UICollectionViewCell>(_ cellClass: T.Type) {
        let className = String(describing: cellClass)
        register(UINib(nibName: className, bundle: nil), forCellWithReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        let className = String(describing: cellClass)
        guard let cell = dequeueReusableCell(withReuseIdentifier: className, for: indexPath) as? T else {
            fatalError("Failed to dequeue cell: \(className)")
        }
        return cell
    }
}

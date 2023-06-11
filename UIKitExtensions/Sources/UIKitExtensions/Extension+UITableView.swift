//
//  Extension+UITableView.swift
//  DictionaryApp
//
//  Created by Emre Cambolat on 27.05.2023.
//

import UIKit

public extension UITableView {
    func registerTable<T: UITableViewCell>(_ cellClass: T.Type) {
        let className = String(describing: cellClass)
        register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        let className = String(describing: cellClass)
        guard let cell = dequeueReusableCell(withIdentifier: className, for: indexPath) as? T else {
            fatalError("Failed to dequeue cell: \(className)")
        }
        return cell
    }
}

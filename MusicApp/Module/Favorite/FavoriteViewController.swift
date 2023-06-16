//
//  FavoriteViewController.swift
//  MusicApp
//
//  Created by Emre Cambolat on 13.06.2023.
//

import UIKit

protocol FavoriteViewProtocol: AnyObject {
    func setupTableView()
    func reloadTableView()
    func setRemoveAllButton()
    func showMessage(_ message: String)
    func showRemoveFavoriteAlert(at: Int)
    func showRemoveAllFavoritesAlert()
    func setEmptyView()
    func showEmptyView()
    func hideEmptyView()
}


final class FavoriteViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var presenter: FavoritePresenterProtocol!
    private let emptyView = EmptyView()
    private var removeAllButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        navigationItem.title = "Favorite Musics"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.fetchFavories()
    }
    
    @objc private func removeAllButtonTap() {
        showRemoveAllFavoritesAlert()
    }
    
    private func makeAlert(message: String, nextButton:  @escaping () -> Void) {
        let alertController = UIAlertController(title: "Are you sure?", message: message, preferredStyle: .alert)
        
        let removeAction = UIAlertAction(title: "Remove", style: .destructive) { (action) in
            nextButton()
        }
        removeAction.isAccessibilityElement = true
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        cancelAction.isAccessibilityElement = true
        
        alertController.addAction(removeAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension FavoriteViewController: FavoriteViewProtocol {
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerTable(FavoriteCell.self)
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setRemoveAllButton() {
        removeAllButton = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(removeAllButtonTap))
        navigationItem.rightBarButtonItem = removeAllButton
    }
    
    func showMessage(_ message: String) { showToast(message) }
    
    func showRemoveFavoriteAlert(at trackID: Int) {
        makeAlert(message: "This song will be removed from your favorites") {
            self.presenter.removeFavorite(with: trackID)
        }
    }
    
    func showRemoveAllFavoritesAlert() {
        makeAlert(message: "All songs in your favorite list will be deleted") {
            self.presenter.removeAllFavorite()
        }
    }
    
    func setEmptyView() {
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(emptyView)
        
        emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        emptyView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        emptyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        emptyView.changeType(.addFavorite)
    }
    
    func showEmptyView() {
        removeAllButton?.isEnabled = false
        emptyView.isHidden = false
    }
    
    func hideEmptyView() {
        removeAllButton?.isEnabled = true
        emptyView.isHidden = true
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(at: indexPath.row)
    }
}
extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { presenter.numberOfItem }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(FavoriteCell.self, for: indexPath)
        cell.selectionStyle = .none
        cell.isAccessibilityElement = true
        
        let music = presenter.favorites(at: indexPath.row)
        cell.cellPresenter = FavoriteCellPresenter(view: cell, music: music)
        cell.cellPresenter.didFavoriteTap = { trackID in self.showRemoveFavoriteAlert(at: trackID)}
        return cell
    }
}

//
//  SearchViewController.swift
//  MusicApp
//
//  Created by Emre Cambolat on 9.06.2023.
//

import UIKit
import UIKitExtensions

protocol SearchViewControllerProtocol: AnyObject {
    func setupTableView()
    func setupSearchBar()
    func reloadData()
    func showAlert(_ message: String)
    func showLoadingView()
    func hideLoadingView()
    func showEmptyView()
    func hideEmptyView()
    func setEmptyView()
    func updateEmptyView(_ type: EmptyViewType)
}

final class SearchViewController: UIViewController, LoadingShowable {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    
    var presenter: SearchPresenterProtocol!
    private let emptyView = EmptyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        navigationItem.title = "iTunes Search"
    }
    
    private func hideKeyboard(){
        view.endEditing(true)
    }
    
}

extension SearchViewController: SearchViewControllerProtocol {
    func updateEmptyView(_ type: EmptyViewType) {
        emptyView.changeType(type)
    }
    
    func showEmptyView() {
        emptyView.isHidden = false
    }
    
    func hideEmptyView() {
        emptyView.isHidden = true
    }
    
    func setEmptyView() {
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(emptyView)
        
        emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        emptyView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        emptyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        emptyView.changeType(.search)
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerTable(MusicCell.self)
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showAlert(_ message: String) { showToast(message) }
    
    func showLoadingView() {
        showLoading()
    }
    
    func hideLoadingView() {
        hideLoading()
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { presenter.numberOfItem }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(MusicCell.self, for: indexPath)
        cell.selectionStyle = .none
        
        if let music = presenter.music(at: indexPath.row) {
            cell.cellPresenter = MusicCellPresenter(view: cell, music: music)
            cell.resetCell()
            if music.trackID == presenter.currentListenID {
                cell.playerView.changePlayerState(.listening)
            } else {
                cell.cellPresenter.didPlayMusic = { trackID in
                    print(trackID)
                    let currentID = self.presenter.currentListenID
                    self.presenter.currentListenID = trackID
                    if currentID == trackID {
                        cell.playerView.changePlayerState(.paused)
                        cell.cellPresenter.load()
                    } else {
                        self.presenter.currentListenID = trackID
                        tableView.reloadData()
                    }
                }
            }
        }
        return cell
    }
}


extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath) as! MusicCell
        selectedCell.playerView.changePlayerState(.paused)
        presenter.didSelectRowAt(index: indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        hideKeyboard()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            presenter.resetSearch()
        } else {
            presenter.searchTimer?.invalidate()
            presenter.searchTimer = Timer.scheduledTimer(withTimeInterval: presenter.searchDelay, repeats: false, block: { [weak self] _ in
                print("istek atıldı")
                self?.presenter.fetchMusic(searchText)
            })
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.fetchMusic(searchBar.text ?? "")
        hideKeyboard()
    }
}

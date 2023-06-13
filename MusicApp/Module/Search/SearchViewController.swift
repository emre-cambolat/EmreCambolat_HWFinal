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
    func showSearchView()
    func hideSearchView()
    func setSearchView()
    func updateSearchView(_ type: SearchResultViewType)
}

final class SearchViewController: UIViewController, LoadingShowable {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
//    @IBOutlet private weak var searchResultView: SearchResultView!
    
    var presenter: SearchPresenterProtocol!
    let searchResultView = SearchResultView()
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        navigationItem.title = "iTunes Search"
    }
    
}

extension SearchViewController: SearchViewControllerProtocol {
    func updateSearchView(_ type: SearchResultViewType) {
        searchResultView.changeType(type)
    }
    
    func showSearchView() {
        searchResultView.isHidden = false
    }
    
    func hideSearchView() {
        searchResultView.isHidden = true
    }
    
    func setSearchView() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height

        searchResultView.backgroundColor = .red
        searchResultView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(searchResultView)
        
        searchResultView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchResultView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchResultView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        searchResultView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
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
    
    func showAlert(_ message: String) {
        showToast(message)
    }
    
    func showLoadingView() {
        showLoading()
    }
    
    func hideLoadingView() {
        hideLoading()
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItem()
    }
    
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
        presenter.didSelectRowAt(index: indexPath.row)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            presenter.resetSearch()
            return
        }
        presenter.searchTimer?.invalidate()
        presenter.searchTimer = Timer.scheduledTimer(withTimeInterval: presenter.searchDelay, repeats: false, block: { [weak self] _ in
            print("istek atıldı")
            self?.presenter.fetchMusic(searchText)
        })
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search button clicked")
    }
}

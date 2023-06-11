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
}

final class SearchViewController: UIViewController, LoadingShowable {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: SearchPresenterProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        presenter.viewDidLoad()
    }
    
}

extension SearchViewController: SearchViewControllerProtocol {
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

//
//  MockSearchViewController.swift
//  MusicAppTests
//
//  Created by Emre Cambolat on 16.06.2023.
//

import Foundation
@testable import MusicApp

final class MockSearchViewController: SearchViewControllerProtocol {
    
    var isInvokedShowLoading = false
    var invokedShowLoadingCount = 0
    
    func showLoadingView() {
        isInvokedShowLoading = true
        invokedShowLoadingCount += 1
    }
    
    var isInvokedHideLoading = false
    var invokedHideLoadingCount = 0
    
    func hideLoadingView() {
        isInvokedHideLoading = true
        invokedHideLoadingCount += 1
    }
    
    var isInvokedSetupTableView = false
    var invokedSetupTableViewCount = 0
    
    func setupTableView() {
        isInvokedSetupTableView = true
        invokedSetupTableViewCount += 1
    }
    
    var isInvokedReloadData = false
    var invokedReloadDataCount = 0
    
    func reloadData() {
        isInvokedReloadData = true
        invokedReloadDataCount += 1
    }
    
    var isInvokedSearchBar = false
    var invokedSearchBarCount = 0
    
    func setupSearchBar() {
        isInvokedSearchBar = true
        invokedSearchBarCount += 1
    }
    
    var isInvokedError = false
    var invokedErrorCount = 0
    
    func showAlert(_ message: String) {
        isInvokedError = true
        invokedErrorCount += 1
    }
    
    var isInvokedShowEmptyView = false
    var invokedShowEmptyViewCount = 0
    
    func showEmptyView() {
        isInvokedShowEmptyView = true
        invokedShowEmptyViewCount += 1
    }
    
    var isInvokedHideEmptyView = false
    var invokedHideEmptyViewCount = 0
    
    func hideEmptyView() {
        isInvokedHideEmptyView = true
        invokedHideEmptyViewCount += 1
    }
    
    var isInvokedSetEmptyView = false
    var invokedSetEmptyViewCount = 0
    
    func setEmptyView() {
        isInvokedSetEmptyView = true
        invokedSetEmptyViewCount += 1
    }
    
    var isInvokedUpdateEmptyView = false
    var invokedUpdateEmptyViewCount = 0
    var invokedUpdateEmptyViewParameters: (type: EmptyViewType, Void)?
    
    func updateEmptyView(_ type: EmptyViewType) {
        isInvokedUpdateEmptyView = true
        invokedUpdateEmptyViewCount += 1
        invokedUpdateEmptyViewParameters = (type, ())
    }
}

//
//  SearchPresenterTests.swift
//  MusicAppTests
//
//  Created by Emre Cambolat on 16.06.2023.
//

import XCTest
@testable import MusicApp

final class SearchPresenterTests: XCTestCase {
    
    var presenter: SearchPresenter!
    var view: MockSearchViewController!
    var interactor: MockSearchInteractor!
    var router: MockSearchRouter!
    
    
    override func setUp() {
        super.setUp()
        
        view = .init()
        interactor = .init()
        router = .init()
        presenter = .init(view: view,
                          router: router,
                          interactor: interactor)
    }
    
    override func tearDown() {
        super.tearDown()
        view = nil
        interactor = nil
        router = nil
        interactor = nil
    }
    
    //    func test_viewDidLoad_InvokesRequiredViewMethods() {
    //        XCTAssertFalse(view.isInvokedSetupTableView)
    //        XCTAssertEqual(view.invokedSetupTableViewCount, 0)
    //
    //        XCTAssertFalse(view.isInvokedUpdateEmptyView)
    //        XCTAssertNil(view.invokedUpdateEmptyViewParameters)
    //
    //        XCTAssertFalse(interactor.isInvokedfetchMusics)
    //        XCTAssertEqual(interactor.isInvokedfetchMusicsCount, 0)
    //
    //        presenter.viewDidLoad()
    //
    //        XCTAssertTrue(view.isInvokedSetupTableView)
    //        XCTAssertEqual(view.invokedSetupTableViewCount, 1)
    //
    //        XCTAssertTrue(view.isInvokedUpdateEmptyView)
    //        XCTAssertEqual(view.invokedUpdateEmptyViewParameters?.type, nil)
    //
    //        XCTAssertTrue(interactor.isInvokedfetchMusics)
    //        XCTAssertEqual(interactor.isInvokedfetchMusicsCount, 1)
    //    }
    
    func test_ShowLoadingView() {
        XCTAssertFalse(view.isInvokedShowLoading)
        XCTAssertEqual(view.invokedShowLoadingCount, 0)
        
        view.showLoadingView()
        
        XCTAssertTrue(view.isInvokedShowLoading)
        XCTAssertEqual(view.invokedShowLoadingCount, 1)
    }
    
    func test_HideLoadingView() {
        XCTAssertFalse(view.isInvokedHideLoading)
        XCTAssertEqual(view.invokedHideLoadingCount, 0)
        
        view.hideLoadingView()
        
        XCTAssertTrue(view.isInvokedHideLoading)
        XCTAssertEqual(view.invokedHideLoadingCount, 1)
    }
    
    func test_SetupTableView() {
        XCTAssertFalse(view.isInvokedSetupTableView)
        XCTAssertEqual(view.invokedSetupTableViewCount, 0)
        
        view.setupTableView()
        
        XCTAssertTrue(view.isInvokedSetupTableView)
        XCTAssertEqual(view.invokedSetupTableViewCount, 1)
    }
    
    func test_ReloadData() {
        XCTAssertFalse(view.isInvokedReloadData)
        XCTAssertEqual(view.invokedReloadDataCount, 0)
        
        view.reloadData()
        
        XCTAssertTrue(view.isInvokedReloadData)
        XCTAssertEqual(view.invokedReloadDataCount, 1)
    }
    
    func test_SetupSearchBar() {
        XCTAssertFalse(view.isInvokedSearchBar)
        XCTAssertEqual(view.invokedSearchBarCount, 0)
        
        view.setupSearchBar()
        
        XCTAssertTrue(view.isInvokedSearchBar)
        XCTAssertEqual(view.invokedSearchBarCount, 1)
    }
    
    func test_ShowAlert() {
        XCTAssertFalse(view.isInvokedError)
        XCTAssertEqual(view.invokedErrorCount, 0)
        
        let message = "Test message"
        
        view.showAlert(message)
        
        XCTAssertTrue(view.isInvokedError)
        XCTAssertEqual(view.invokedErrorCount, 1)
    }
    
    func test_ShowEmptyView() {
        XCTAssertFalse(view.isInvokedShowEmptyView)
        XCTAssertEqual(view.invokedShowEmptyViewCount, 0)
        
        view.showEmptyView()
        
        XCTAssertTrue(view.isInvokedShowEmptyView)
        XCTAssertEqual(view.invokedShowEmptyViewCount, 1)
    }
    
    func test_HideEmptyView() {
        XCTAssertFalse(view.isInvokedHideEmptyView)
        XCTAssertEqual(view.invokedHideEmptyViewCount, 0)
        
        view.hideEmptyView()
        
        XCTAssertTrue(view.isInvokedHideEmptyView)
        XCTAssertEqual(view.invokedHideEmptyViewCount, 1)
    }
    
    func test_SetEmptyView() {
        XCTAssertFalse(view.isInvokedSetEmptyView)
        XCTAssertEqual(view.invokedSetEmptyViewCount, 0)
        
        view.setEmptyView()
        
        XCTAssertTrue(view.isInvokedSetEmptyView)
        XCTAssertEqual(view.invokedSetEmptyViewCount, 1)
    }
    
    func test_UpdateEmptyView() {
        XCTAssertFalse(view.isInvokedUpdateEmptyView)
        XCTAssertEqual(view.invokedUpdateEmptyViewCount, 0)
        
        let type: EmptyViewType = .noResult
        
        view.updateEmptyView(type)
        
        XCTAssertTrue(view.isInvokedUpdateEmptyView)
        XCTAssertEqual(view.invokedUpdateEmptyViewCount, 1)
        XCTAssertEqual(view.invokedUpdateEmptyViewParameters?.type, type)
    }
    
    func test_fetchMusicsOutput() {
        XCTAssertFalse(view.isInvokedHideLoading)
        XCTAssertEqual(presenter.numberOfItem, 0)
        XCTAssertFalse(view.isInvokedReloadData)
        
        presenter.fetchMusicOutput(Musics.response)
        
        XCTAssertTrue(view.isInvokedHideLoading)
        XCTAssertEqual(presenter.numberOfItem, 50)
        XCTAssertTrue(view.isInvokedReloadData)
    }
}

extension Musics {
    static var response: Musics {
        let bundle = Bundle(for: SearchPresenterTests.self)
        let path = bundle.path(forResource: "Music", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)
        let response = try! JSONDecoder().decode(Musics.self, from: data!)
        return response
    }
}

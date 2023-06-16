//
//  MusicAppUITests.swift
//  MusicAppUITests
//
//  Created by Emre Cambolat on 7.06.2023.
//

import XCTest

final class MusicAppUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("******** UITest ********")
    }
    
    func testExample() throws {
        launchApp()
        checkTabBar()
        tapFavoritesButton()
        tapSearchButton()
        searchMusic("Tarkan")
        waitForSearchResults()
        selectMusicCell("Şımarık, Tarkan, Ölürüm Sana")
        XCTAssertTrue(musicDetailViewNavigationBar.exists)
        toggleFavorite()
        removeMusicFromFavorites()
        tapWindowElement()
        returnToSearch()
        selectMusicCell("Kuzu Kuzu, Tarkan, Karma")
        XCTAssertTrue(musicDetailViewNavigationBar.exists)
        toggleFavorite()
        tapSearchButton()
        clearSearchText()
        tapFavoritesButton()
        XCTAssertTrue(trashButton.exists)
        deleteMusicFromFavorites()
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

// MARK: - Helpers

extension MusicAppUITests {
    private var tabBar: XCUIElement {
        return app.tabBars["Tab Bar"]
    }
    
    private var favoritesButton: XCUIElement {
        return tabBar.buttons["Favorites"]
    }
    
    private var searchButton: XCUIElement {
        return tabBar.buttons["Search"]
    }
    
    private var searchSearchField: XCUIElement {
        return app.searchFields["Search"]
    }
    
    private var tablesQuery: XCUIElementQuery {
        return app.tables
    }
    
    private var musicDetailViewNavigationBar: XCUIElement {
        return app.navigationBars["MusicApp.DetailView"]
    }
    
    private var favoriteButton: XCUIElement {
        return musicDetailViewNavigationBar.buttons["favorite"]
    }
    
    private var removeButton: XCUIElement {
        return app.alerts["Are you sure?"].scrollViews.otherElements.buttons["Remove"]
    }
    
    private var windowElement: XCUIElement {
        return app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
    }
    
    private var secondMusicCell: XCUIElement {
        return tablesQuery.cells["Kuzu Kuzu, Tarkan, Karma"]
    }
    
    private var trashButton: XCUIElement {
        return app.navigationBars["Favorite Musics"].buttons["trash"]
    }
    
    // MARK: - Test Cases
    
    private func launchApp() {
        app.launch()
        sleep(2)
    }
    
    private func checkTabBar() {
        XCTAssertTrue(tabBar.exists)
        XCTAssertTrue(favoritesButton.exists)
        XCTAssertTrue(searchButton.exists)
    }
    
    private func tapFavoritesButton() {
        favoritesButton.tap()
        sleep(1)
    }
    
    private func tapSearchButton() {
        searchButton.tap()
    }
    
    private func searchMusic(_ text: String) {
        searchSearchField.tap()
        sleep(1)
        searchSearchField.typeText(text)
    }
    
    private func waitForSearchResults() {
        sleep(5)
    }
    
    private func selectMusicCell(_ identifier: String) {
        let musicCell = tablesQuery.cells[identifier]
        XCTAssertTrue(musicCell.exists)
        musicCell.staticTexts["Tarkan"].tap()
    }
    
    private func toggleFavorite() {
        favoriteButton.tap()
        sleep(3)
        favoriteButton.tap()
    }
    
    private func removeMusicFromFavorites() {
        removeButton.tap()
        sleep(3)
    }
    
    private func tapWindowElement() {
        windowElement.tap()
        sleep(5)
        windowElement.tap()
    }
    
    private func returnToSearch() {
        musicDetailViewNavigationBar.buttons["iTunes Search"].tap()
        sleep(1)
    }
    
    private func clearSearchText() {
        let clearTextButton = searchSearchField.buttons["Clear text"]
        clearTextButton.tap()
        sleep(1)
    }
    
    private func deleteMusicFromFavorites() {
        trashButton.tap()
        sleep(2)
        removeButton.tap()
        sleep(2)
    }
}

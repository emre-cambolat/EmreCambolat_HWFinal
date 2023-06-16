//
//  MusicAppUITests.swift
//  MusicAppUITests
//
//  Created by Emre Cambolat on 7.06.2023.
//

import XCTest

final class MusicAppUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // UI tests must launch the application that they test.
        
        let app = XCUIApplication()
        app.launch()
        
        delay(seconds: 2)
        let tabBar = app.tabBars["Tab Bar"]
        let favoritesButton = tabBar.buttons["Favorites"]
        favoritesButton.tap()
        delay(seconds: 1)
        
        let searchButton = tabBar.buttons["Search"]
        searchButton.tap()
        
        let searchSearchField = app.searchFields["Search"]
        searchSearchField.tap()
        delay(seconds: 1)
        searchSearchField.typeText("Tarkan")
        
        
        delay(seconds: 5)
        
        let tablesQuery = app.tables
        tablesQuery.cells["Şımarık, Tarkan, Ölürüm Sana"].staticTexts["Tarkan"].tap()
        
        let musicappDetailviewNavigationBar = app.navigationBars["MusicApp.DetailView"]
        let favoriteButton = musicappDetailviewNavigationBar.buttons["favorite"]
        favoriteButton.tap()
        delay(seconds: 3)
        favoriteButton.tap()
        
        app.alerts["Are you sure?"].scrollViews.otherElements.buttons["Remove"].tap()
        delay(seconds: 3)
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.tap()
        delay(seconds: 5)
        element.tap()
        musicappDetailviewNavigationBar.buttons["iTunes Search"].tap()
        delay(seconds: 1)
        tablesQuery.cells["Kuzu Kuzu, Tarkan, Karma"].staticTexts["Tarkan"].tap()
        delay(seconds: 1)
        favoriteButton.tap()
        delay(seconds: 2)
        searchButton.tap()
        delay(seconds: 1)
        searchSearchField.buttons["Clear text"].tap()
        delay(seconds: 1)
        favoritesButton.tap()
        delay(seconds: 2)
        
        app.navigationBars["Favorite Musics"].buttons["trash"].tap()
        delay(seconds: 2)
        app.alerts["Are you sure?"].scrollViews.otherElements.buttons["Remove"].tap()
        delay(seconds: 2)
        
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    private func delay(seconds: Double) {
            let expectation = XCTestExpectation(description: "Expectation of delay")
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: seconds)
        }
}

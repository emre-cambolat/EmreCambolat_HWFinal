//
//  MockSearchRouter.swift
//  MusicAppTests
//
//  Created by Emre Cambolat on 16.06.2023.
//

import Foundation
@testable import MusicApp

final class MockSearchRouter: SearchRouterProtocol {
    
    var isInvokedNavigate = false
    var invokedNavigateCount = 0
    var invokedNavigateParameters: (route: SearchRoutes, Void)?
    
    func navigate(_ route: SearchRoutes) {
        isInvokedNavigate = true
        invokedNavigateCount += 1
        invokedNavigateParameters = (route, ())
    }
}

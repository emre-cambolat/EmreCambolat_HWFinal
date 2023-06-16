//
//  MockSearchInteractor.swift
//  MusicAppTests
//
//  Created by Emre Cambolat on 16.06.2023.
//

import Foundation
@testable import MusicApp


final class MockSearchInteractor: SearchInteractorProtocol {
    
    var isInvokedfetchMusics = false
    var isInvokedfetchMusicsCount = 0
    
    func fetchMusic(_ term: String) {
        isInvokedfetchMusics = true
        isInvokedfetchMusicsCount += 1
    }
}

//
//  TmdbTabBarViewModelTests.swift
//  TMDBTests
//
//  Created by Mohitnnd on 23/03/21.
//

import XCTest
@testable import TMDB

class TmdbTabBarViewModelTests: XCTestCase {
    
    let viewModel = TmdbTabBarViewModel()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTabBarItems_should_contain_trending_nowPlaying_search_in_order() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let sut: [TmdbTabBarViewModel.Item] = viewModel.items.value
        
        let requiredOrder: [TmdbTabBarViewModel.Item] = [TmdbTabBarViewModel.Item.trending,
                                                             TmdbTabBarViewModel.Item.nowPlaying,
                                                             TmdbTabBarViewModel.Item.search]
        
        XCTAssertEqual(sut, requiredOrder,"Tab bar items are not in correct order")
    }
    
    func testTabBarItems_should_have_expected_title_for_trending_nowPlaying_search() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let sut: [String] = viewModel.items.value.map { $0.rawValue }
        
        let requiredOrder: [String] = ["Trending", "Now Playing", "Search"]
        
        XCTAssertEqual(sut, requiredOrder,"Tab bar item display names are not correct")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

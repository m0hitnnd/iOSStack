//
//  TmdbTabBarViewModel.swift
//  TMDB
//
//  Created by Mohitnnd on 23/03/21.
//

import Foundation
import UIKit

final class TmdbTabBarViewModel {
    
    enum Item: String, CaseIterable {        
        case trending = "Trending"
        case nowPlaying = "Now Playing"
        case search = "Search"
        
        func tabBarItem() -> UITabBarItem {
            switch self {
            case .nowPlaying:
                return UITabBarItem.init(title: self.rawValue,
                                         image: UIImage.init(systemName: "play.circle"),
                                         selectedImage: UIImage.init(systemName: "play.circle.fill"))
            case .search:
                return UITabBarItem.init(title: self.rawValue,
                                         image: UIImage.init(systemName: "magnifyingglass"),
                                         selectedImage: UIImage.init(systemName: "magnifyingglass"))
            case .trending:
                return UITabBarItem.init(title: self.rawValue,
                                         image: UIImage.init(systemName: "star"),
                                         selectedImage: UIImage.init(systemName: "star.fill"))
            }
        }
        
        func getController() -> UIViewController {
            switch self {
            case .nowPlaying:
                return NowPlayingViewController()
            case .search:
                return SearchViewController()
            case .trending:
                return TrendingViewController()
            }
        }
    }
    
    var items: Dynamic<[TmdbTabBarViewModel.Item]> = .init(TmdbTabBarViewModel.Item.allCases)
}

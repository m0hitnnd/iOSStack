//
//  TmdbTabBarViewModel.swift
//  Hollywoo
//
//  Created by Mohitnnd on 23/03/21.
//

import Foundation
import UIKit

final class TmdbTabBarViewModel {
    
    enum Item: String, CaseIterable {        
        case watchNow = "Watch Now"
        case search = "Search"
        
        func tabBarItem() -> UITabBarItem {
            switch self {
            case .watchNow:
                return UITabBarItem.init(title: self.rawValue,
                                         image: UIImage.init(systemName: "play.circle"),
                                         selectedImage: UIImage.init(systemName: "play.circle.fill"))
            case .search:
                return UITabBarItem.init(title: self.rawValue,
                                         image: UIImage.init(systemName: "magnifyingglass"),
                                         selectedImage: UIImage.init(systemName: "magnifyingglass"))
            }
        }
        
        func getController() -> UIViewController {
            switch self {
            case .watchNow:
                return NowPlayingViewController()
            case .search:
                return SearchViewController()
            }
        }
    }
    
    var items: Dynamic<[TmdbTabBarViewModel.Item]> = .init(TmdbTabBarViewModel.Item.allCases)
}

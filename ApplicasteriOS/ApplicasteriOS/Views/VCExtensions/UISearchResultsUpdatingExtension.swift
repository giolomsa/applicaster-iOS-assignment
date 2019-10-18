//
//  UISearchResultsUpdatingExtension.swift
//  ApplicasteriOS
//
//  Created by Gio Lomsa on 10/18/19.
//  Copyright © 2019 Giorgi Lomsadze. All rights reserved.
//

import Foundation
import UIKit

extension RootViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            self.viewModel.filteredPosts = self.viewModel.unfilteredPosts.filter { post in
                return post.title.lowercased().contains(searchText.lowercased())
            }
            
        } else {
            self.viewModel.filteredPosts = self.viewModel.unfilteredPosts
        }
        postsTableView.reloadData()
    }
}

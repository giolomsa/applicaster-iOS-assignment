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
    //MARK:- UISearchResultUpdating method
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            self.viewModel.filteredPosts = self.viewModel.unfilteredPosts.filter {$0.title.lowercased().contains(searchText.lowercased())}
            
            if self.viewModel.filteredPosts.count == 0{
                self.noResultLabel.text = "\(searchText) did not match any news."
                self.noResultLabel.isHidden = false
            }else{
                self.noResultLabel.isHidden = true
            }
        } else {
            self.viewModel.filteredPosts = self.viewModel.unfilteredPosts
        }
        postsTableView.reloadData()
    }
}

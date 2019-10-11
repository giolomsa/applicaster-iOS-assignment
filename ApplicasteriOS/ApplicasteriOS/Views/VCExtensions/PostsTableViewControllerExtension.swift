//
//  PostsTableViewControllerExtension.swift
//  ApplicasteriOS
//
//  Created by Gio Lomsa on 10/10/19.
//  Copyright © 2019 Giorgi Lomsadze. All rights reserved.
//

import Foundation
import UIKit

extension RootViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentPost = self.viewModel.posts[indexPath.row]
        
        switch currentPost.postType{
        case .link:
            if let cell = postsTableView.dequeueReusableCell(withIdentifier: "LinkTableViewCell", for: indexPath) as? LinkTableViewCell{
                let currentPost = self.viewModel.posts[indexPath.row]
                cell.textLabel?.text = currentPost.title
            }
        case .video:
            if let cell = postsTableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath) as? VideoTableViewCell{
                let currentPost = self.viewModel.posts[indexPath.row]
                cell.textLabel?.text = currentPost.title
            }
        }
        
        return UITableViewCell()
    }
    
    
}

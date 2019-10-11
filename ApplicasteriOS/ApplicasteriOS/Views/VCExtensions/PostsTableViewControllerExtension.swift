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
                cell.postTitleLabel.text = "\(currentPost.title) link"
                return cell
            }else{
                return UITableViewCell()
            }
            
        case .video:
            if let cell = postsTableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath) as? VideoTableViewCell{
                let currentPost = self.viewModel.posts[indexPath.row]
                cell.postTitleLabel.text = "\(currentPost.title) Video"
                
                return cell
            }else{
                return UITableViewCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPost = viewModel.posts[indexPath.row]
        
        switch selectedPost.postType{
        case .link:
            print("link")
            if let urlString = selectedPost.link{
                  self.selectedPostUrlString = urlString
                performSegue(withIdentifier: "WebPageVCSegue", sender: self)
            }
        case .video:
            print("video")
            if let urlString = selectedPost.content{
                self.playVideo(urlString: urlString)
            }
        }
    }
    
    
}

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
    
    //MARK:- UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = postsTableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell{
            
            let currentPost = self.viewModel.filteredPosts[indexPath.row]
            cell.updateCell(for: currentPost)
            cell.tag = indexPath.row
            
            let imageUrl = currentPost.mediaGroup?.first?.src ?? "defaultsImageUrl"
            
            DispatchQueue.global(qos: .background).async {
                self.viewModel.loadImageFromUrl(for: imageUrl, completion: {[weak cell] (image) in
                    DispatchQueue.main.async {
                        if cell?.tag == indexPath.row{
                            cell?.updateImage(set: image)
                        }
                    }
                })
            }
            
            cell.playImageView.isHidden = currentPost.postType == .link ? true : false
            
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    //MARK:- didSelectRowAt method
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPost = viewModel.filteredPosts[indexPath.row]
        self.selectedPost = selectedPost
        
        switch selectedPost.postType{
        case .link:
            print("link")
                performSegue(withIdentifier: "WebPageVCSegue", sender: self)
        case .video:
            print("video")
                self.playVideo(urlString: selectedPost.content ?? "defaultVideoLink")
        }
    }
    
    
}

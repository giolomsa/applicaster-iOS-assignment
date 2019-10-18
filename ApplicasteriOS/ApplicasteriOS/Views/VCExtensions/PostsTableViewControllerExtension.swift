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
        return viewModel.filteredPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentPost = self.viewModel.filteredPosts[indexPath.row]
        
        switch currentPost.postType{
        case .link:
            if let cell = postsTableView.dequeueReusableCell(withIdentifier: "LinkTableViewCell", for: indexPath) as? LinkTableViewCell{
                
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
                
                return cell
            }else{
                return UITableViewCell()
            }

        case .video:
            if let cell = postsTableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath) as? VideoTableViewCell{
                let currentPost = self.viewModel.filteredPosts[indexPath.row]
                
                cell.updateCell(for: currentPost)
                cell.tag = indexPath.row
                
                let imageUrl = currentPost.mediaGroup?.first?.src ?? "defaultsImageUrl"
                
                DispatchQueue.global(qos: .background).async {
                    self.viewModel.loadImageFromUrl(for:
                        imageUrl, completion: {[weak cell] (image) in
                        DispatchQueue.main.async {
                            if cell?.tag == indexPath.row{
                                cell?.updateImage(set: image)
                            }
                        }
                    })
                }
                
                return cell
            }else{
                return UITableViewCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPost = viewModel.filteredPosts[indexPath.row]
        
        print(selectedPost)
        guard let urlString = selectedPost.link else {return}
        
        switch selectedPost.postType{
        case .link:
            print("link")
                  self.selectedPostUrlString = urlString
                performSegue(withIdentifier: "WebPageVCSegue", sender: self)
        case .video:
            print("video")
//                self.playVideo(urlString: urlString)
        }
    }
    
    
}

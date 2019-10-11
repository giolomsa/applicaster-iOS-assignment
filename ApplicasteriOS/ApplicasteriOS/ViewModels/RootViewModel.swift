//
//  RootViewModel.swift
//  ApplicasteriOS
//
//  Created by Gio Lomsa on 10/10/19.
//  Copyright © 2019 Giorgi Lomsadze. All rights reserved.
//

import Foundation

class RootViewModel{
    
    static let postsWereSetNotification = Notification.Name.init(rawValue: "gio.lomsa.postsWereSetNotification")
    
    var posts = [Post](){
        didSet{
            NotificationCenter.default.post(name: RootViewModel.postsWereSetNotification, object: nil)
        }
    }
    
    func loadPosts(){
        // populate test data
        var tempPosts = [Post]()
        for i in 0..<10{
            let type = i % 2 == 0 ? PostType.link : PostType.video
            let post = Post(title: "Post title", summary: "Larry has been given a permutation of a sequence of natural numbers", published: "09/09/2019", mediaGroup: "MediaGroup", mediaItem: ["1":"1"], postType: type, link: "http://", content: "http://")
            tempPosts.append(post)
        }
        self.posts = tempPosts
    }
    
}

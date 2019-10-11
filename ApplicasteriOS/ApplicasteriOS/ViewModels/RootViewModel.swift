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
            let post = Post(title: "Post title: Larry has been given a permutation of a sequence of natural numbers Larry has been given a permutation of a sequence of natural numbers", summary: "Larry has been given a permutation of a sequence of natural numbers", published: "09/09/2019", mediaGroup: "MediaGroup", mediaItem: ["1":"1"], postType: type, link: "https://www.bbc.com/news/business-50009761", content: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_adv_example_hevc/master.m3u8")
            tempPosts.append(post)
        }
        self.posts = tempPosts
    }
    
}

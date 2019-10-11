//
//  Post.swift
//  ApplicasteriOS
//
//  Created by Gio Lomsa on 10/10/19.
//  Copyright © 2019 Giorgi Lomsadze. All rights reserved.
//

import Foundation

enum PostType: String{
        case link = "link"
        case video = "video"
    }

class Post: Codable{
    
    var title: String
    var summary: String
    var published: String
    var mediaGroup: String
    var mediaItem: [String: String]
    var postType: PostType
    var link: String?
    var content: String?
    
    init(title: String, summary: String, published: String, mediaGroup: String, mediaItem: [String: String], postType: PostType, link: String?, content: String?){
        
        self.title = title
        self.summary = summary
        self.published = published
        self.mediaItem = mediaItem
        self.mediaGroup = mediaGroup
        self.postType = postType
        self.link = link
        self.content = content
    }
    
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case summary = "summary"
        case published = "published"
        case mediaItem = "mediaItem"
        case mediaGroup = "mediaGroup"
        case postType = "postType"
        case link = "link"
        case content = "content"
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try container.decode(String.self, forKey: .title)
        self.summary = try container.decode(String.self, forKey: .summary)
        self.published = try container.decode(String.self, forKey: .published)
        self.mediaItem = try container.decode([String: String].self, forKey: .mediaItem)
        self.mediaGroup = try container.decode(String.self, forKey: .mediaGroup)
        self.link = try container.decode(String.self, forKey: .link)
        self.content = try container.decode(String.self, forKey: .content)
        
        let postType = try container.decode(String.self, forKey: .postType)
        self.postType = PostType(rawValue: postType) ?? .link
        
        

    }
}

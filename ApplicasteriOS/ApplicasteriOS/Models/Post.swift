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
    
    private enum CodingKeys: String, CodingKey {
        
        case type = "type"
        case title = "title"
        case summary = "summary"
        case published = "published"
        case content = "content"
        case link = "link"
        case mediaGroup = "media_group"

    }
    //
    private enum TypeKeys: String, CodingKey{
        case typeValue = "value"
    }
    //
    private enum ContentKeys: String, CodingKey{
        case content = "content"
    }
    //
    private enum LinkKeys: String, CodingKey{
        case href = "href"
    }
    //
    private enum MediaGroupKeys: String, CodingKey{
//        case type = "type"
        case mediaItems = "media_item"
    }
    //
    private enum MediaItemKeys: String, CodingKey{
        case src = "src"
    }
    
    ////

    var title: String
    var summary: String
    var published: String
    var mediaGroup: [MediaItem]?
    var postType: PostType
    var link: String?
    var content: String?

    func encode(to encoder: Encoder) throws {

    }

    required init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.title = try container.decode(String.self, forKey: .title)
        self.summary = try container.decode(String.self, forKey: .summary)
        self.published = try container.decode(String.self, forKey: .published)

        var mediaGroupContainer = try container.nestedUnkeyedContainer(forKey: .mediaGroup)
        let mediaItemsContainer = try mediaGroupContainer.nestedContainer(keyedBy: MediaGroupKeys.self)
        
        self.mediaGroup = try mediaItemsContainer.decodeIfPresent([MediaItem].self, forKey: .mediaItems)
//
        
        let typeContainer = try container.nestedContainer(keyedBy: TypeKeys.self, forKey: .type)
        let type = try typeContainer.decode(String.self, forKey: .typeValue)
        self.postType = PostType(rawValue: type) ?? .link
        
        let contentContainer = try container.nestedContainer(keyedBy: ContentKeys.self, forKey: .content)
        self.content = try contentContainer.decode(String.self, forKey: .content)
        
        let linkContainer = try container.nestedContainer(keyedBy: LinkKeys.self, forKey: .link)
        self.link = try linkContainer.decode(String.self, forKey: .href )

    }
}

class PostsContainer: Codable{
    var entry: [Post]?
}

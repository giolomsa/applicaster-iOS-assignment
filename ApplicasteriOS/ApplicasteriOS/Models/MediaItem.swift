//
//  MediaItem.swift
//  ApplicasteriOS
//
//  Created by Gio Lomsa on 10/17/19.
//  Copyright © 2019 Giorgi Lomsadze. All rights reserved.
//

import Foundation

//MARK:- Media item Type/Scale enums
enum MediaItemType: String{
    case image = "image"
    case video = "video"
}

enum MediaItemScale: String{
    case small = "small"
    case large = "large"
}

class MediaItem: Codable{
    
    var src: String
    var type: MediaItemType
    var scale: MediaItemScale
    var key: String
    
    //MARK:- Coding key enum
    enum CodingKeys:String, CodingKey{
        case src = "src"
        case type = "type"
        case scale = "scale"
        case key = "key"
    }
   
    //MARK:- encode/decode
    required init(from decoder: Decoder) throws {
        let container =  try decoder.container(keyedBy: CodingKeys.self)
        
        let type = try container.decode(String.self, forKey: .type)
        self.type = MediaItemType.init(rawValue: type ) ?? .image
        
        let scale = try container.decode(String.self, forKey: .scale)
        self.scale = MediaItemScale.init(rawValue: scale ) ?? .small
        
        self.src = try container.decode(String.self, forKey: .src)
        self.key = try container.decode(String.self, forKey: .key)
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
    
}

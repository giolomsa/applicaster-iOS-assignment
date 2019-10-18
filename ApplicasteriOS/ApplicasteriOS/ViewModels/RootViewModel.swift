//
//  RootViewModel.swift
//  ApplicasteriOS
//
//  Created by Gio Lomsa on 10/10/19.
//  Copyright © 2019 Giorgi Lomsadze. All rights reserved.
//

import Foundation
import UIKit

class RootViewModel{
    
    let httpLayer = HTTPLayer()
    let apiClient: APIClient
    private let imageCache = NSCache<NSString, UIImage>()
    
    init() {
        apiClient = APIClient(httpLayer: httpLayer)
    }
    
    static let postsWereSetNotification = Notification.Name.init(rawValue: "gio.lomsa.postsWereSetNotification")
    
    var unfilteredPosts = [Post](){
        didSet{
            NotificationCenter.default.post(name: RootViewModel.postsWereSetNotification, object: nil)
        }
    }
    
    var filteredPosts = [Post](){
        didSet{
            NotificationCenter.default.post(name: RootViewModel.postsWereSetNotification, object: nil)
        }
    }
    
    func loadPosts(){
   
        self.apiClient.getPostsFromServer {[weak self] (result) in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let posts):
                self?.unfilteredPosts = posts
            }
        }
    }
    
    func loadImageFromUrl(for urlString: String, completion: @escaping(UIImage)->Void){
        
            var image = UIImage()
            
            if let cachedImage = self.imageCache.object(forKey: NSString(string: urlString )){
                print("Image From Cach")
                completion(cachedImage)
            }else{
                apiClient.downloadImage(for: urlString) { (result) in
                    switch result{
                    case .success(let imageData):
                        image = UIImage(data: imageData)!
                        self.imageCache.setObject(image, forKey: NSString(string: urlString))
                        print("Image From URL")
                        completion(image)
                    case .failure(let error):
                        print(error)
                        //TODO:- Show error alert
                        return
                }
            }
        }
    }
}

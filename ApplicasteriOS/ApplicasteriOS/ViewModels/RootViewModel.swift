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
    
    //MARK:- variables/constants
    private let httpLayer = HTTPLayer()
    private let apiClient: APIClient
    private let imageCache = NSCache<NSString, UIImage>()
    
    var filteredPosts = [Post]()
    private var _posts = [Post]()
    
    static let postsWereSetNotification = Notification.Name.init(rawValue: "gio.lomsa.postsWereSetNotification")
    
    var unfilteredPosts = [Post](){
        didSet{
            filteredPosts = unfilteredPosts
            NotificationCenter.default.post(name: RootViewModel.postsWereSetNotification, object: nil)
        }
    }
    
    //
    init() {
        apiClient = APIClient(httpLayer: httpLayer)
    }
    
    //MARK:- class methods
    func loadPosts(){
        
        //Create operation for downloading posts from server
        let downloadPostsFromServer = BlockOperation{
            // create dispatch group
            let dispatchGroup = DispatchGroup()
            
            dispatchGroup.enter()
            self.apiClient.getPostsFromApplicastercom{[weak self](result) in
                switch result{
                case .failure(let error):
                    print(error)
                case .success(let posts):
                    self?._posts.append(contentsOf: posts)
                }
                dispatchGroup.leave()
            }
            
            dispatchGroup.enter()
            self.apiClient.getPostsFromAWS{[weak self](result) in
                switch result{
                case .failure(let error):
                    print(error)
                case .success(let posts):
                    self?._posts.append(contentsOf: posts)
                }
                dispatchGroup.leave()
            }
            dispatchGroup.wait()
        }
        
        let setPostsOperation = BlockOperation{
            self.unfilteredPosts = self._posts
        }
        // sert operation dependencies
        setPostsOperation.addDependency(downloadPostsFromServer)
        // start operations
        downloadPostsFromServer.start()
        setPostsOperation.start()
    }
    
    // load image from url string
    func loadImageFromUrl(for urlString: String, completion: @escaping(UIImage)->Void){
        
            var image = UIImage()
            
            if let cachedImage = self.imageCache.object(forKey: NSString(string: urlString )){
                print("Image From Cach")
                completion(cachedImage)
            }else{
                apiClient.downloadImage(for: urlString) { (result) in
                    switch result{
                    case .success(let imageData):
                        image = UIImage(data: imageData) ?? UIImage()
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

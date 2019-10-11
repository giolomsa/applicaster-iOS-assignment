//
//  APIClient.swift
//  ApplicasteriOS
//
//  Created by Gio Lomsa on 10/10/19.
//  Copyright © 2019 Giorgi Lomsadze. All rights reserved.
//

import Foundation

class APIClient{
    
    let httpLayer: HTTPLayer
    var defaultError: NSError = NSError(domain: "", code: 1, userInfo: nil)
    
    enum Result<Element>{
        case success(Element)
        case failure(NSError)
    }
    
    init(httpLayer: HTTPLayer){
        self.httpLayer = httpLayer
    }
    
    //load feed elements
    func getFeedElements(completion: @escaping (Result<[Post]>)-> Void){
        
        self.httpLayer.request(at: .root) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode.isSuccessHTTPCode,
                let data = data
                else {
                    if let error = error{
                        completion(.failure(error as NSError))
                    }else{
//                     print(error)
                    }
                    return
            }
            do{
                let decoder = JSONDecoder()
                print(data)
                let posts = try decoder.decode([Post].self, from: data)
                completion(.success(posts))
            }catch let error{
                print(error.localizedDescription)
            }
        }
    }
}

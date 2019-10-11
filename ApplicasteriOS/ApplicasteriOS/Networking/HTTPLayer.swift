//
//  HTTPLayer.swift
//  ApplicasteriOS
//
//  Created by Gio Lomsa on 10/10/19.
//  Copyright © 2019 Giorgi Lomsadze. All rights reserved.
//

import Foundation


class HTTPLayer{
    
    let urlSession = URLSession.shared
    
    enum Endpoint{
        case root
        case fromUrl(String)
        
        var path: String{
            switch self {
            case .root:
                return "http://assets-production.applicaster.com/applicasteremployees/israel_team/Elad/assignment/link_json.json"
            case .fromUrl(let url):
                return url
            }
        }
    }
    
    func request(at endpoint: Endpoint, completion: @escaping (Data?, URLResponse?, Error?)-> Void){
        
        let urlString = endpoint.path
        guard let url = URL(string: urlString) else {return }
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            completion(data, response, error)
        }
        task.resume()
    }
}

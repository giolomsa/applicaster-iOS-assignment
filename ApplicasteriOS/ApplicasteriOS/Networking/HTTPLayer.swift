//
//  HTTPLayer.swift
//  ApplicasteriOS
//
//  Created by Gio Lomsa on 10/10/19.
//  Copyright © 2019 Giorgi Lomsadze. All rights reserved.
//

import Foundation


class HTTPLayer: NSObject, URLSessionDelegate{
    
    var urlSession = URLSession.shared
    
    enum Endpoint{
        case applicastercom
        case aws
        case fromUrl(String)
        
        var path: String{
            switch self {
            case .applicastercom:
                return "https://assets-production.applicaster.com/applicaster-employees/israel_team/Elad/assignment/link_json.json"
            case .aws:
                return "https://assets-production.applicaster.com.s3.amazonaws.com/applicaster-employees/israel_team/Elad/assignment/link_json.json"
            case .fromUrl(let url):
                return url
            }
        }
    }
    
    func request(at endpoint: Endpoint, completion: @escaping (Data?, URLResponse?, Error?)-> Void){
        self.urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: .none)
        let urlString = endpoint.path
//        print(urlString)
        guard let url = URL(string: urlString) else {return }
//        print(url)
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            completion(data, response, error)
        }
        task.resume()
    
        
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
    
        if challenge.previousFailureCount > 0 { completionHandler(Foundation.URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge, nil)
        } else if let serverTrust = challenge.protectionSpace.serverTrust {
            completionHandler(Foundation.URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: serverTrust))
        } else {
            return
        }
    }
}

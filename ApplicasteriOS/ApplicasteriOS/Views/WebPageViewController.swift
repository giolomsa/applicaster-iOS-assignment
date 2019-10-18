//
//  WebPageViewController.swift
//  ApplicasteriOS
//
//  Created by Gio Lomsa on 10/10/19.
//  Copyright © 2019 Giorgi Lomsadze. All rights reserved.
//

import UIKit
import WebKit

class WebPageViewController: UIViewController {

    var selectedPostUrlString: String?
    
    //MARK:- IBOutlets
    @IBOutlet weak var webView: WKWebView!    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        activityIndicator.startAnimating()
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        customizeUI()
        loadWebPage()
}

    //MARK:- private methods
    private func loadWebPage(){
        
        guard let urlString = selectedPostUrlString,
            let postUrl = URL(string: urlString)else{
                showErrorAlert(); return                
        }

        let request = URLRequest(url: postUrl)
        
        webView.configuration.allowsInlineMediaPlayback = true
        webView.allowsBackForwardNavigationGestures = true
        webView.load(request)        
    }

    private func customizeUI(){
        loadingView.layer.cornerRadius = 10.0
    }
    
    private func showErrorAlert(){
        
    }
}

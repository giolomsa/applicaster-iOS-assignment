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

    //MARK:- variables/constants
    var selectedPost: Post?
    
    //MARK:- IBOutlets
    @IBOutlet weak var webView: WKWebView!    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        activityIndicator.startAnimating()
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        customizeUI()
        loadWebPage()
        
        navigationController?.navigationBar.isHidden = false
}
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.navigationBar.isHidden = false
    }

    //MARK:- private methods
    private func loadWebPage(){
        
        guard let selectedPost = selectedPost,
            let urlString = selectedPost.link,
            let postUrl = URL(string: urlString)else{
                showErrorAlert(); return                
        }

        let request = URLRequest(url: postUrl)
        
        webView.configuration.allowsInlineMediaPlayback = true
        webView.allowsBackForwardNavigationGestures = true
        webView.load(request)
    }

    private func customizeUI(){
        navigationItem.title = selectedPost?.title
        
        loadingView.layer.cornerRadius = 10.0
    }
    
    private func showErrorAlert(){
        //TODO:- show error alert
    }
}

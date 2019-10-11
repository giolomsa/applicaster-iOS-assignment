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
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let string = self.selectedPostUrlString{
            print(string)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ViewController.swift
//  ApplicasteriOS
//
//  Created by Gio Lomsa on 10/10/19.
//  Copyright © 2019 Giorgi Lomsadze. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let httpLayer = HTTPLayer()
        let networking = APIClient(httpLayer: httpLayer)
        
        networking.getFeedElements { (result) in
            switch result{
            case .success(let elements):
                print("data")
                print(elements)
            case .failure(let error):
                print(error)
            }
        }
    }


}


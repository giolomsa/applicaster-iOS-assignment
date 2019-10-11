//
//  ViewController.swift
//  ApplicasteriOS
//
//  Created by Gio Lomsa on 10/10/19.
//  Copyright © 2019 Giorgi Lomsadze. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    //MARK:- Variables/Constants
    let viewModel = RootViewModel()
    
    //MARK:- IBOutlets
    @IBOutlet weak var postsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        postsTableView.delegate = self
        postsTableView.dataSource = self
        
//        let httpLayer = HTTPLayer()
//        let networking = APIClient(httpLayer: httpLayer)
        
        manageObservers()
        viewModel.loadPosts()
    }
    
    //add observers
    private func manageObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(updateUIFromViewModel), name: RootViewModel.postsWereSetNotification, object: nil)
    }
    
    @objc private func updateUIFromViewModel(){
        
    }


}


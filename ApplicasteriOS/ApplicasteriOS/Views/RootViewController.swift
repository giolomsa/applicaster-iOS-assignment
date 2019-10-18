//
//  ViewController.swift
//  ApplicasteriOS
//
//  Created by Gio Lomsa on 10/10/19.
//  Copyright © 2019 Giorgi Lomsadze. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class RootViewController: UIViewController {
    
    //MARK:- Variables/Constants
    let viewModel = RootViewModel()
    var selectedPostUrlString: String?
    let searchController = UISearchController(searchResultsController: nil)
    
    //MARK:- IBOutlets
    @IBOutlet weak var postsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Posts"
        postsTableView.delegate = self
        postsTableView.dataSource = self
        postsTableView.tableHeaderView = searchController.searchBar
        
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        
        
        manageObservers()
        DispatchQueue.global(qos: .background).async {
            self.viewModel.loadPosts()
        }
    }
    
    //add observers
    private func manageObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(updateUIFromViewModel), name: RootViewModel.postsWereSetNotification, object: nil)
    }
    
    @objc private func updateUIFromViewModel(){
        DispatchQueue.main.async {
            self.postsTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? WebPageViewController,
            segue.identifier == "WebPageVCSegue",
            let selectedPostUrlString = self.selectedPostUrlString{
            destination.selectedPostUrlString = selectedPostUrlString
        }
    }
    
    //MARK:- class methods
    func playVideo(urlString: String){
        guard let url = URL(string: urlString) else {
            return
        }
        let player = AVPlayer(url: url)
        let vc = AVPlayerViewController()
        vc.player = player
        
        present(vc, animated: true) {
            vc.player?.play()
        }

    }


}


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
    var selectedPost: Post?
    let searchController = UISearchController(searchResultsController: nil)
    var searchControllerPresented = false
    
    //MARK:- IBOutlets
    @IBOutlet weak var noResultLabel: UILabel!
    @IBOutlet weak var postsTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK:- Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Posts"
        
        customizeUI()
        
        postsTableView.delegate = self
        postsTableView.dataSource = self
        
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        
        manageObservers()
        
        //load posts in viewModel
        DispatchQueue.global(qos: .background).async {
            self.viewModel.loadPosts()
        }
    }
    
    //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    //
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController.dismiss(animated: false, completion: nil)
    }
    
    //MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? WebPageViewController,
            segue.identifier == "WebPageVCSegue",
            let selectedPostUrlString = self.selectedPost{
            destination.selectedPost = selectedPostUrlString
        }
    }
    
    //add observers
    private func manageObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(updateUIFromViewModel), name: RootViewModel.postsWereSetNotification, object: nil)
    }
    
    //MARK:- CustomUI method
    private func customizeUI(){
        self.searchController.searchBar.tintColor = .white
        searchController.searchBar.backgroundColor = UIColor.red
        searchController.searchBar.barTintColor = UIColor(displayP3Red: 215/255, green: 57/255, blue: 51/255, alpha: 1.0)
        

        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "Logo")
        imageView.image = image
        navigationItem.titleView = imageView
        navigationController?.navigationBar.backgroundColor = UIColor.white
        
        activityIndicator.startAnimating()
        
    }
    
    //MARK:- class methods
    @objc private func updateUIFromViewModel(){
        DispatchQueue.main.async {
            self.postsTableView.reloadData()
            print(self.viewModel.filteredPosts.count)
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
    
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

    //MARK:- IBActions
    @IBAction func searchButtonTapped(_ sender: UIBarButtonItem) {
        searchController.hidesNavigationBarDuringPresentation = false
            if !searchController.isActive{
                present(searchController, animated: true, completion: nil)
            }
        }
}


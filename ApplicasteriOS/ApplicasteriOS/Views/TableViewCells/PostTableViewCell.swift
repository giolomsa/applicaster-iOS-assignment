//
//  LinkTableViewCell.swift
//  ApplicasteriOS
//
//  Created by Gio Lomsa on 10/10/19.
//  Copyright © 2019 Giorgi Lomsadze. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    //MARK:- IBOutlets
    @IBOutlet weak var playImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postPublishedLabel: UILabel!
    @IBOutlet weak var postSummaryTextView: UITextView!
    
    //MARK:- Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        postImageView.layer.cornerRadius = 0.0
        playImageView.layer.cornerRadius = playImageView.frame.width/2
        activityIndicator.startAnimating()
        postImageView.image = nil
    }

    //MARK:- class methods
    func updateCell(for post: Post){
        self.postTitleLabel.text = post.title
        self.postSummaryTextView.text = post.summary
        self.postPublishedLabel.text = post.published.dateStringToLocaleDateString
        
    }
    
    func updateImage(set image: UIImage){
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        self.postImageView.image = image
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

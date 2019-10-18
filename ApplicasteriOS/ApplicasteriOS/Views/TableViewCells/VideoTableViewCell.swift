//
//  VideoTableViewCell.swift
//  ApplicasteriOS
//
//  Created by Gio Lomsa on 10/10/19.
//  Copyright © 2019 Giorgi Lomsadze. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTitleLabel: UILabel!    
    @IBOutlet weak var postPublishedLabel: UILabel!
    @IBOutlet weak var playButtonBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        playButtonBackgroundView.layer.cornerRadius = playButtonBackgroundView.frame.width / 2
    }
    
    func updateCell(for post: Post){
        self.postTitleLabel.text = post.title
        self.postPublishedLabel.text = post.published ;#warning("add extension for publish date")
        
    }
    
    func updateImage(set image: UIImage){
        self.postImageView.image = image
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

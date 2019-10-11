//
//  LinkTableViewCell.swift
//  ApplicasteriOS
//
//  Created by Gio Lomsa on 10/10/19.
//  Copyright © 2019 Giorgi Lomsadze. All rights reserved.
//

import UIKit

class LinkTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postPublishedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        postImageView.layer.cornerRadius = 8.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

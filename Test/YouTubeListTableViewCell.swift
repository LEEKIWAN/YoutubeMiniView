//
//  YoutubeListTableViewCell.swift
//  Test
//
//  Created by kiwan on 2020/01/03.
//  Copyright © 2020 kiwan. All rights reserved.
//

import UIKit

class YouTubeListTableViewCell: UITableViewCell {

    @IBOutlet weak var thumnailImageView: UIImageView!
    @IBOutlet weak var writerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        writerImageView.layer.cornerRadius = writerImageView.frame.size.height / 2
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

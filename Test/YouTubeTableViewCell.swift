//
//  YouTubeTableViewCell.swift
//  Test
//
//  Created by kiwan on 2020/01/03.
//  Copyright © 2020 kiwan. All rights reserved.
//

import UIKit

class YouTubeTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var playTimeButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        playTimeButton.layer.cornerRadius = 4
        thumbnailImageView.layer.cornerRadius = 5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

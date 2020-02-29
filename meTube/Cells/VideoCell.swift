//
//  VideoCell.swift
//  meTube
//
//  Created by Felipe Amorim Bastos on 29/02/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import UIKit
import Kingfisher

class VideoCell: UITableViewCell {
    
    @IBOutlet var imgThumbnail: UIImageView?
    @IBOutlet var lblTitle: UILabel?
    @IBOutlet var lblDescription: UILabel?
    @IBOutlet var vwContent: UIView?
    
    func loadUI(item: Items) {
        
        lblTitle?.text = item.snippet?.title
        lblDescription?.text = item.snippet?.description
        
        if let thumbnailURL = item.snippet?.thumbnails?.medium?.url {
            self.imgThumbnail?.kf.setImage(with: URL(string: thumbnailURL))
        }
    }
}

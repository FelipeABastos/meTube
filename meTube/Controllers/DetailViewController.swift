//
//  DetailViewController.swift
//  meTube
//
//  Created by Felipe Amorim Bastos on 29/02/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var video: Items!
    
    @IBOutlet var imgThumbnail: UIImageView?
    @IBOutlet var lblTitle: UILabel?
    @IBOutlet var lblDescription: UILabel?
    @IBOutlet var lblViews: UILabel?
    
    //-----------------------------------------------------------------------
    //    MARK: UIViewController
    //-----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setGradientBackgroundUpDown(bottomColor: UIColor(red:0.96, green:0.96, blue:0.98, alpha:1.0), topColor: UIColor(red:0.86, green:0.87, blue:0.88, alpha:1.0))
        
        lblTitle?.text = video.snippet?.title
        lblDescription?.text = video.snippet?.description
        
        if let thumbnailURL = video.snippet?.thumbnails?.high?.url {
            imgThumbnail?.kf.setImage(with: URL(string: thumbnailURL))
        }
    }
    
    //-----------------------------------------------------------------------
    //    MARK: Custom methods
    //-----------------------------------------------------------------------
    
    @IBAction func backToHome() {
        self.dismiss(animated: true, completion: nil)
    }
}

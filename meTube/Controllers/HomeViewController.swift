//
//  HomeViewController.swift
//  meTube
//
//  Created by Felipe Amorim Bastos on 29/02/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var listVideos: Array<Items> = []
    var nextPageToken: String = ""
    
    @IBOutlet var constraintMarginTopButton: NSLayoutConstraint!
    @IBOutlet var constraintVerticalAlignButton: NSLayoutConstraint!
    @IBOutlet var constraintMarginLeftButton: NSLayoutConstraint!
    @IBOutlet var constraintButtonHeight: NSLayoutConstraint!
    @IBOutlet var constraintMarginRightButton: NSLayoutConstraint!
    
    @IBOutlet var constraintMarginRightField: NSLayoutConstraint!
    @IBOutlet var constraintFieldHeight: NSLayoutConstraint!
    @IBOutlet var constraintFieldMarginLeft: NSLayoutConstraint!
    @IBOutlet var constraintFieldVerticalAlign: NSLayoutConstraint!
    
    @IBOutlet var constraintTxtInputRight: NSLayoutConstraint!
    
    @IBOutlet var vwInput: UIView?
    
    @IBOutlet var constraintHeaderHeight: NSLayoutConstraint!
    
    @IBOutlet var constraintLogoHeight: NSLayoutConstraint!
    @IBOutlet var constraintLogoTop: NSLayoutConstraint!
    @IBOutlet var constraintLogoBot: NSLayoutConstraint!
    @IBOutlet var constraintLogoWidth: NSLayoutConstraint!
    
    @IBOutlet var vwButton: UIView?
    @IBOutlet var vwBackground: UIView?
    @IBOutlet var imgLogo: UIImageView?
    @IBOutlet var txtInput: UITextField?
    @IBOutlet var btnSearch: UIButton?
    @IBOutlet var vwHeader: UIView?
    
    let refresh = UIRefreshControl()
    
    @IBOutlet var tbVideos: UITableView?
    
    //-----------------------------------------------------------------------
    //    MARK: UIViewController
    //-----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    //-----------------------------------------------------------------------
    //    MARK: UITableView Delegate / Datasource
    //-----------------------------------------------------------------------
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listVideos.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let video = listVideos[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell") as! VideoCell
        cell.loadUI(item: video)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let video: Items = listVideos[indexPath.row]
        
        let detailVC = storyboard?.instantiateViewController(identifier: "DetailView") as! DetailViewController
        detailVC.video = video
        self.present(detailVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == listVideos.count - 1 {
            
            RequestManager.getVideos(title: txtInput?.text ?? "", pageToken: nextPageToken) { (videos, pageToken) in
                self.nextPageToken = pageToken
                self.listVideos.append(contentsOf: videos)
                self.tbVideos?.reloadData()
            }
        }
    }
    
    //-----------------------------------------------------------------------
    //    MARK: Custom methods
    //-----------------------------------------------------------------------
    
    func configUI() {
        
        tintPlaceHolder()
        btnSearch?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        vwBackground?.setGradientBackgroundUpDown(bottomColor: UIColor(red:0.96, green:0.96, blue:0.98, alpha:1.0), topColor: UIColor(red:0.86, green:0.87, blue:0.88, alpha:1.0))
        
        btnSearch?.setGradientBackgroundLeftRight(rightColor: UIColor(red:0.55, green:0.48, blue:0.90, alpha:1.0), leftColor: UIColor(red:0.00, green:0.59, blue:0.90, alpha:1.0))
        
        vwInput?.layer.borderColor = UIColor(red:0.44, green:0.50, blue:0.58, alpha:1.0).cgColor
        
        constraintHeaderHeight?.constant = UIScreen.main.bounds.height
        self.constraintFieldVerticalAlign.constant = -100
        
        refresh.addTarget(self, action: #selector(loadVideos), for: UIControl.Event.valueChanged)
        self.tbVideos?.addSubview(refresh)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgLogo?.isUserInteractionEnabled = true
        imgLogo?.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func loadVideos() {
        
        RequestManager.getVideos(title: txtInput?.text ?? "", pageToken: nextPageToken) { (result,pageToken) in
            
            self.nextPageToken = pageToken
            self.listVideos = result
            self.tbVideos?.reloadSections(IndexSet(integer: 0), with: .bottom)
            self.refresh.endRefreshing()
        }
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        print("imageTapped")
        
        constraintHeaderHeight?.constant = UIScreen.main.bounds.height
        
        self.constraintMarginTopButton.priority = .defaultHigh
        self.constraintVerticalAlignButton.priority = .defaultLow
        
        self.constraintMarginLeftButton.constant = 50
        self.constraintButtonHeight.constant = 60
        self.constraintMarginRightButton.constant = 50
        
        self.constraintTxtInputRight.constant = 8
        
        self.btnSearch?.layer.cornerRadius = 30
        self.btnSearch?.clipsToBounds = true
        
        self.vwInput?.layer.cornerRadius = 30
        self.vwInput?.clipsToBounds = true
        
        self.constraintFieldHeight.constant = 60
        self.constraintFieldMarginLeft.constant = 50
        self.constraintMarginRightField.constant = 50
        self.constraintFieldVerticalAlign.constant = -100
        
        self.constraintLogoHeight.constant = 100
        self.constraintLogoWidth.constant = 200
        
        self.constraintLogoTop.priority = .defaultLow
        self.constraintLogoBot.priority = .defaultHigh
        
        btnSearch?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        UIView.animate(withDuration: 0.9) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func searchVideo() {
        
        self.constraintMarginTopButton.priority = .defaultLow
        self.constraintVerticalAlignButton.priority = .defaultHigh
        vwButton?.layer.shadowOpacity = 0
        btnSearch?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        self.constraintButtonHeight.constant = 45
        self.constraintMarginLeftButton.constant = ((self.vwHeader?.bounds.width)! / 4) * 3.1
        self.constraintMarginRightButton.constant = 15
        self.constraintVerticalAlignButton.constant = 15
        
        self.constraintMarginRightField.constant = ((self.vwHeader?.bounds.width)! / 9)
        self.constraintFieldHeight.constant = 45
        self.constraintFieldMarginLeft.constant = 15
        self.constraintFieldVerticalAlign.constant = 15
        
        self.constraintTxtInputRight.constant = 20
        self.vwInput?.layer.cornerRadius = self.vwInput!.frame.width/14
        self.vwInput?.clipsToBounds = true
        
        self.constraintHeaderHeight.constant = 115
        
        self.constraintLogoTop.priority = .defaultHigh
        self.constraintLogoBot.priority = .defaultLow
        
        self.constraintLogoWidth.constant = 100
        self.constraintLogoHeight.constant = 40
        
        self.btnSearch?.layer.cornerRadius = self.btnSearch!.frame.width/14
        self.btnSearch?.clipsToBounds = true
        
        loadVideos()
        
        self.view.endEditing(true)
        
        UIView.animate(withDuration: 0.9) {
            self.view.layoutIfNeeded()
        }
    }
    
    func tintPlaceHolder() {
        if let placeholder = txtInput?.placeholder {
            txtInput?.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.6)])
        }
    }
}


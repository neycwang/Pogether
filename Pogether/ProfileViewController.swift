//
//  ProfileViewController.swift
//  Pogether
//
//  Created by apple on 2017/1/17.
//  Copyright © 2017年 Wang. All rights reserved.
//

import SnapKit

class ProfileViewController: UIViewController
{
    var scrollView: UIScrollView!
    var wallpaperView: UIImageView!
    var iconView: UIImageView!
    var width, height: CGFloat!
    
    func initialize() {
        width = view.frame.width
        height = view.frame.height
        
        wallpaperView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height / 2))
        wallpaperView.image = #imageLiteral(resourceName: "profile")
        
        scrollView = UIScrollView(frame: view.frame)
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 1
        scrollView.contentSize = CGSize(width: width, height: height * 2)
        
        iconView = UIImageView(frame: CGRect(x: width / 2 - 50, y: height / 2 - 50, width: 100, height: 100))
        iconView.image = #imageLiteral(resourceName: "icon")
        let imageLayer = iconView.layer
        imageLayer.masksToBounds = true
        imageLayer.cornerRadius = iconView.frame.size.height / 2
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initialize()
        view.addSubview(wallpaperView)
        view.addSubview(scrollView)
        scrollView.addSubview(iconView)
    }
    
}

    //MARK: scrollcontrol

extension ProfileViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        if scrollView.contentOffset.y < 0
        {
            let ratio =  -scrollView.contentOffset.y * 2 / height
            wallpaperView.frame = CGRect(x: -ratio * width / 2, y: 0, width: width * (1 + ratio), height: height / 2 * (1 + ratio))
        }
        else
        {
            let offset = scrollView.contentOffset.y
            wallpaperView.frame = CGRect(x: 0, y: -offset, width: width, height: height / 2)
        }
    }
}

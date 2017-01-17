//
//  ProfileViewController.swift
//  Pogether
//
//  Created by apple on 2017/1/17.
//  Copyright © 2017年 Wang. All rights reserved.
//

import SnapKit

class ProfileViewController: UIViewController, UIScrollViewDelegate
{
    var scrollView: UIScrollView!
    var imageView, iconView: UIImageView!
    
    var width, height: CGFloat!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        width = view.frame.width
        height = view.frame.height
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height / 2))
        imageView.image = UIImage(named: "3096.jpg")
        view.addSubview(imageView)
        
        scrollView = UIScrollView(frame: view.frame)
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 1
        scrollView.contentSize = CGSize(width: width, height: height * 2)
        view.addSubview(scrollView)
        
        let v = UIView(frame: CGRect(x: 0, y: height / 2, width: width, height: height * 1.5))
        v.backgroundColor = UIColor.red
        scrollView.addSubview(v)
        
        iconView = UIImageView(frame: CGRect(x: width / 2 - 50, y: height / 2 - 50, width: 100, height: 100))
        iconView.image = UIImage(named: "3096.jpg")
        scrollView.addSubview(iconView)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        if scrollView.contentOffset.y < 0
        {
            let ratio =  -scrollView.contentOffset.y * 2 / height
            imageView.frame = CGRect(x: -ratio * width / 2, y: 0, width: width * (1 + ratio), height: height / 2 * (1 + ratio))
        }
        else
        {
            let offset = scrollView.contentOffset.y
            imageView.frame = CGRect(x: 0, y: -offset, width: width, height: height / 2)
        }
    }
}

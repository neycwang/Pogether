//
//  PresentationViewController.swift
//  Pogether
//
//  Created by KiraMelody on 2017/2/12.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import UIKit

class PresentationViewController: UIViewController {

    var photoImageView: UIImageView!
    var canDelete: Bool = false
    var photo: UIImage!
    var scrollImageView: UIScrollView!
    func initialize()
    {
        if canDelete
        {
            let deleteItem = UIBarButtonItem (title: "删除", style: .plain, target: self, action: #selector(deletePhoto))
            self.navigationItem.rightBarButtonItem = deleteItem
        }
        var backImage = #imageLiteral(resourceName: "ContactList_Back")
        backImage = backImage.withRenderingMode(.alwaysOriginal)
        let backItem = UIBarButtonItem (image: backImage, style: .plain, target: self, action: #selector(backToLast))
        self.navigationItem.leftBarButtonItem = backItem
        
        let addButton = UIButton(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 46, width: UIScreen.main.bounds.width, height: 46))
        addButton.titleLabel?.isHidden = false
        addButton.setTitleColor(UIColor.white, for: .normal)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        addButton.backgroundColor = ColorandFontTable.primaryPink
        if canDelete
        {
            addButton.setTitle("编辑", for: .normal)
            addButton.addTarget(self, action: #selector(editPhoto), for: UIControlEvents.touchUpInside)
        } else {
            addButton.setTitle("收藏", for: .normal)
            addButton.addTarget(self, action: #selector(storePhoto), for: UIControlEvents.touchUpInside)
        }
        self.view.addSubview(addButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        self.title = "详情"
        self.view.backgroundColor = ColorandFontTable.groundGray
        
        //创建并添加scrollView
        scrollImageView = UIScrollView()
        self.view.addSubview(scrollImageView)
        scrollImageView.backgroundColor = ColorandFontTable.groundGray
        scrollImageView.contentSize = photo.size
        scrollImageView.delegate = self
        scrollImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(70)
            make.bottom.equalTo(self.view).offset(-50)
            make.left.equalTo(self.view).offset(10)
            make.right.equalTo(self.view).offset(-10)
        }
        
        scrollImageView.minimumZoomScale = 0.3
        scrollImageView.maximumZoomScale = 2.0
        scrollImageView.bouncesZoom = true
        scrollImageView.showsVerticalScrollIndicator = false
        scrollImageView.showsHorizontalScrollIndicator = false
        photoImageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.width - 20, height: self.view.frame.height - 120)))
        photoImageView.image = photo
        photoImageView.contentMode = .scaleAspectFit
        scrollImageView.addSubview(photoImageView)
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(scrollViewDoubleTapped(recognizer:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.numberOfTouchesRequired = 1
        scrollImageView.addGestureRecognizer(doubleTapRecognizer)
    }
    override func viewWillAppear(_ animated: Bool) {
        centerScrollViewContents()
        self.navigationController?.setToolbarHidden(true, animated: false)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backToLast()
    {
        let _ = self.navigationController?.popViewController(animated: true)
    }

    func deletePhoto()
    {
        let delete = UIAlertAction(title: "删除照片", style: UIAlertActionStyle.default) { (UIAlertAction) in
            return
        }
        let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) { (UIAlertAction) in
            return
        }
        let alert = UIAlertController(title: "您将删除本张照片", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(delete)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
    }
    func editPhoto()
    {
        let evc = EditViewController()
        evc.photo = self.photo
        self.navigationController?.pushViewController(evc, animated: true)
    }
    func storePhoto()
    {
        
    }
    func centerScrollViewContents() {
        let boundsSize = scrollImageView.bounds.size
        var contentsFrame = photoImageView.frame
        
        if contentsFrame.size.width < boundsSize.width {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
        } else {
            contentsFrame.origin.x = 0.0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
        } else {
            contentsFrame.origin.y = 0.0
        }
        
        photoImageView.frame = contentsFrame
    }
}
extension PresentationViewController: UIScrollViewDelegate
{
    // MARK: - UIScrollViewDelegate
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerScrollViewContents()
    }
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat)
    {
        if scrollView.minimumZoomScale >= scale
        {
            scrollView.setZoomScale(0.3, animated: true)
        }
        if scrollView.maximumZoomScale <= scale
        {
            scrollView.setZoomScale(2.0, animated: true)
        }
    }
    func scrollViewDoubleTapped(recognizer: UITapGestureRecognizer) {
        let pointInView = recognizer.location(in: photoImageView)
        
        var newZoomScale = scrollImageView.zoomScale * 1.5
        newZoomScale = min(newZoomScale, scrollImageView.maximumZoomScale)
        
        let scrollViewSize = scrollImageView.bounds.size
        let w = scrollViewSize.width / newZoomScale
        let h = scrollViewSize.height / newZoomScale
        let x = pointInView.x - (w / 2.0)
        let y = pointInView.y - (h / 2.0)
        
        let rectToZoomTo = CGRect(x: x, y: y, width: w, height: h)
        
        scrollImageView.zoom(to: rectToZoomTo, animated: true)
    }
    
}



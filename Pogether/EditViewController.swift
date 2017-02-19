//
//  EditViewController.swift
//  Pogether
//
//  Created by KiraMelody on 2017/2/12.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    var photoImageView: UIImageView!
    var photo: UIImage!
    var scrollImageView: UIScrollView!
    func initialize()
    {
        var backImage = #imageLiteral(resourceName: "ContactList_Back")
        backImage = backImage.withRenderingMode(.alwaysOriginal)
        let backItem = UIBarButtonItem (image: backImage, style: .plain, target: self, action: #selector(backToLast))
        self.navigationItem.leftBarButtonItem = backItem
        
        photoImageView = UIImageView(frame: self.view.frame)
        photoImageView.contentMode = .scaleAspectFit
        photoImageView.image = photo
        
        let crop = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Edit"), style: .plain, target: self, action: #selector(jumpToCrop))
        let augment = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Augment"), style: .plain, target: self, action: #selector(jumpToAugment))
        let matting = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Matting"), style: .plain, target: self, action: #selector(jumpToMatting))
        let text = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Text"), style: .plain, target: self, action: #selector(jumpToText))
        let cancel = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Cancel"), style: .plain, target: self, action: #selector(backToLast))
        let save = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Save"), style: .plain, target: self, action: #selector(backToLast))
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let barArray = [cancel, space, crop, space, augment, space, matting, space, text, space, save]
        self.toolbarItems = barArray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        self.title = "编辑"
        self.view.backgroundColor = ColorandFontTable.groundGray
        
        //创建并添加scrollView
        scrollImageView = UIScrollView()
        self.view.addSubview(scrollImageView)
        scrollImageView.backgroundColor = ColorandFontTable.groundGray
        scrollImageView.contentSize = photo.size
        scrollImageView.delegate = self
        scrollImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-50)
            make.left.equalTo(self.view).offset(10)
            make.right.equalTo(self.view).offset(-10)
        }
        
        let scrollViewFrame = scrollImageView.frame
        let scaleWidth = scrollViewFrame.size.width / scrollImageView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / scrollImageView.contentSize.height
        let minScale = min(scaleWidth, scaleHeight)
        scrollImageView.minimumZoomScale = 0.3
        scrollImageView.maximumZoomScale = 2.0
        scrollImageView.zoomScale = minScale
        scrollImageView.bouncesZoom = true
        scrollImageView.showsVerticalScrollIndicator = false
        scrollImageView.showsHorizontalScrollIndicator = false
        photoImageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.width - 20, height: self.view.frame.height - 120)))
        photoImageView.image = photo
        photoImageView.contentMode = .scaleAspectFit
        scrollImageView.addSubview(photoImageView)
        
        centerScrollViewContents()
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(scrollViewDoubleTapped(recognizer:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.numberOfTouchesRequired = 1
        scrollImageView.addGestureRecognizer(doubleTapRecognizer)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setToolbarHidden(false, animated: false)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backToLast()
    {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    func jumpToCrop()
    {
        let avc = CropViewController()
        avc.photo = self.photo
        self.navigationController?.pushViewController(avc, animated: false)
    }
    func jumpToAugment()
    {
        let avc = AugmentViewController()
        avc.photo = self.photo
        self.navigationController?.pushViewController(avc, animated: false)
    }
    func jumpToMatting()
    {
        let avc = MattingViewController()
        avc.photo = self.photo
        self.navigationController?.pushViewController(avc, animated: false)
    }
    func jumpToText()
    {
        let avc = TextViewController()
        avc.photo = self.photo
        self.navigationController?.pushViewController(avc, animated: false)
    }
    func editPhoto()
    {
        
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
extension EditViewController: UIScrollViewDelegate
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


//
//  AugmentViewController.swift
//  Pogether
//
//  Created by KiraMelody on 2017/2/15.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import UIKit

class AugmentViewController: UIViewController {

    var photoImageView: UIImageView!
    var photo: UIImage!
    var scrollImageView: UIScrollView!
    var groundView: UIView!
    var slider: UISlider!
    var sliderLabel : UILabel!
    
    func initialize()
    {
        let a0 = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Brightness"), style: .plain, target: self, action: #selector(brightnessSlider))
        let a1 = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Saturation"), style: .plain, target: self, action: #selector(saturationSlider))
        let a2 = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Contrast"), style: .plain, target: self, action: #selector(contrastSlider))
        let cancel = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Cancel"), style: .plain, target: self, action: #selector(backToLast))
        let save = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Save"), style: .plain, target: self, action: #selector(backToLast))
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let barArray = [cancel, space, a0, space, a1, space, a2, space, save]
        self.toolbarItems = barArray
        
        groundView = UIView()
        groundView.backgroundColor = ColorandFontTable.primaryPink
        
        slider = UISlider()
        slider.minimumTrackTintColor = ColorandFontTable.purple
        slider.maximumTrackTintColor = ColorandFontTable.fillGray
        slider.thumbTintColor = UIColor.white
        
        sliderLabel = UILabel()
        sliderLabel.font = UIFont.systemFont(ofSize: 14)
        sliderLabel.textColor = UIColor.white
        
        //创建并添加scrollView
        scrollImageView = UIScrollView()
        self.view.addSubview(scrollImageView)
        scrollImageView.backgroundColor = ColorandFontTable.groundGray
        scrollImageView.contentSize = photo.size
        scrollImageView.delegate = self
        scrollImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(20)
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
        
        photoImageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.width - 20, height: self.view.frame.height - 190)))
        photoImageView.image = photo
        photoImageView.contentMode = .scaleAspectFit
        scrollImageView.addSubview(photoImageView)
        
        centerScrollViewContents()
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(scrollViewDoubleTapped(recognizer:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.numberOfTouchesRequired = 1
        scrollImageView.addGestureRecognizer(doubleTapRecognizer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        self.view.addSubview(groundView)
        self.view.addSubview(slider)
        self.view.addSubview(sliderLabel)
        groundView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view).offset(-45)
            make.height.equalTo(60)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
        }
        slider.snp.makeConstraints { (make) in
            make.centerX.equalTo(groundView)
            make.top.equalTo(groundView).offset(10)
            make.height.equalTo(20)
            make.width.equalTo(280)
        }
        sliderLabel.snp.makeConstraints { (make) in
            make.top.equalTo(slider.snp.bottom).offset(8)
            make.centerX.equalTo(slider)
        }
        self.view.backgroundColor = ColorandFontTable.groundGray
        self.groundView.isHidden = true
        self.slider.isHidden = true
        self.sliderLabel.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setToolbarHidden(false, animated: false)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    func brightnessSlider()
    {
        self.groundView.isHidden = false
        self.slider.isHidden = false
        self.sliderLabel.isHidden = false
        sliderLabel.text = "亮度"
        slider.value = 50
        slider.minimumValue = 0
        slider.maximumValue = 100
    }
    func saturationSlider()
    {
        self.groundView.isHidden = false
        self.slider.isHidden = false
        self.sliderLabel.isHidden = false
        sliderLabel.text = "饱和度"
        slider.minimumValue = 0
        slider.maximumValue = 10
    }
    func contrastSlider()
    {
        self.groundView.isHidden = false
        self.slider.isHidden = false
        self.sliderLabel.isHidden = false
        sliderLabel.text = "对比度"
        slider.minimumValue = 0
        slider.maximumValue = 1
    }
    func backToLast()
    {
        let _ = self.navigationController?.popViewController(animated: true)
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

extension AugmentViewController: UIScrollViewDelegate
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


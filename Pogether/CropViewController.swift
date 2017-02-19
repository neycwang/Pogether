//
//  CropViewController.swift
//  Pogether
//
//  Created by KiraMelody on 2017/2/15.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import UIKit

class CropViewController: UICollectionViewController {

    //var photoImageView: UIImageView!
    var photo: UIImage!
    var cropPhoto: UIImage!
    var dataArray = [(String, (Int, Int))]()
    var resetButton: UIButton!
    var cutButton: UIButton!
    var scrollImageView: UIScrollView!
    var cropImageView: TKImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init()
    {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 60, height: 80)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: UIScreen.main.bounds.height - 140, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        super.init(collectionViewLayout: layout)
        let height = self.view.frame.height
        let width = self.view.frame.width
        collectionView = UICollectionView(frame: CGRect(x: 0, y: height - 140, width: width, height: 80), collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.backgroundColor = ColorandFontTable.groundGray
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.bounces = false
        self.collectionView!.register(CropCollectionViewCell.self, forCellWithReuseIdentifier: "CropCollectionViewCell")
        
        resetButton = UIButton()
        resetButton.addTarget(self, action: #selector(reset), for: .touchUpInside)
        resetButton.setTitle("重置", for: .normal)
        resetButton.setTitleColor(ColorandFontTable.textPink, for: .normal)
        resetButton.backgroundColor = UIColor.clear
        resetButton.layer.borderColor = ColorandFontTable.fillGray.cgColor
        resetButton.layer.cornerRadius = 15
        resetButton.layer.masksToBounds = true
        resetButton.layer.borderWidth = 2
        
        cutButton = UIButton()
        cutButton.addTarget(self, action: #selector(cutting), for: .touchUpInside)
        cutButton.setTitle("裁剪", for: .normal)
        cutButton.setTitleColor(ColorandFontTable.textPink, for: .normal)
        cutButton.backgroundColor = UIColor.clear
        cutButton.layer.borderColor = ColorandFontTable.fillGray.cgColor
        cutButton.layer.cornerRadius = 15
        cutButton.layer.masksToBounds = true
        cutButton.layer.borderWidth = 2
        
        let crop = UIBarButtonItem(title: "裁剪", style: .plain, target: nil, action: nil)
        let cancel = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Cancel"), style: .plain, target: self, action: #selector(backToLast))
        let save = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Save"), style: .plain, target: self, action: #selector(backToLast))
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let barArray = [cancel, space, crop, space, save]
        self.toolbarItems = barArray
        
        dataArray = [("原型",(48, 32)), ("1 : 1",(36, 36)), ("2 : 3",(24, 36)), ("3 : 2",(36, 24)), ("3 : 4",(27, 36)), ("4 : 3",(36, 27)), ("9 : 16",(18, 32))]
        
        collectionView!.addSubview(resetButton)
        collectionView!.addSubview(cutButton)
        
        resetButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(20)
            make.bottom.equalTo(self.view).offset(-130)
            make.width.equalTo(70)
            make.height.equalTo(30)
        }
        cutButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.view).offset(-20)
            make.bottom.equalTo(self.view).offset(-130)
            make.width.equalTo(70)
            make.height.equalTo(30)
        }
        
    }
    
    
    //MARK:- View Control
    override func viewWillAppear(_ animated: Bool) {
        //创建并添加scrollView
        scrollImageView = UIScrollView()
        self.view.addSubview(scrollImageView)
        scrollImageView.backgroundColor = ColorandFontTable.groundGray
        scrollImageView.contentSize = photo.size
        scrollImageView.delegate = self
        scrollImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(20)
            make.bottom.equalTo(self.view).offset(-170)
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
        cropImageView = TKImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.width - 20, height: self.view.frame.height - 190)))
        cropImageView.toCropImage = self.photo
        cropImageView.needScaleCrop = false
        cropImageView.showMidLines = true
        cropImageView.showCrossLines = true
        cropImageView.cornerBorderInImage = true
        cropImageView.cropAreaCornerWidth = 44
        cropImageView.cropAreaCornerHeight = 44
        cropImageView.minSpace = 30
        cropImageView.cropAreaCrossLineColor = UIColor.white
        cropImageView.cropAreaBorderLineColor = UIColor.white
        cropImageView.cropAreaCornerLineColor = ColorandFontTable.primaryPink
        cropImageView.cropAreaMidLineColor = ColorandFontTable.primaryPink
        cropImageView.cropAreaCornerLineWidth = 3
        cropImageView.cropAreaBorderLineWidth = 1
        cropImageView.cropAreaMidLineWidth = 30
        cropImageView.cropAreaMidLineHeight = 3
        cropImageView.cropAreaCrossLineWidth = 1
        cropImageView.contentMode = .scaleAspectFit
        scrollImageView.addSubview(cropImageView)
        
        centerScrollViewContents()
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(scrollViewDoubleTapped(recognizer:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.numberOfTouchesRequired = 1
        scrollImageView.addGestureRecognizer(doubleTapRecognizer)
        
        self.navigationController?.setToolbarHidden(false, animated: false)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setToolbarHidden(true, animated: false)
    }

    
    
    //MARK:- Data Source
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView!.dequeueReusableCell(withReuseIdentifier: "CropCollectionViewCell", for: indexPath) as! CropCollectionViewCell
        cell.iconView.snp.makeConstraints { (make) in
            make.width.equalTo(dataArray[indexPath.row].1.0)
            make.height.equalTo(dataArray[indexPath.row].1.1)
        }
        cell.titleLabel.text = "\(dataArray[indexPath.row].0)"
        cell.backgroundColor = ColorandFontTable.primaryPink
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            cropImageView.cropAspectRatio = 0
        } else {
            let width = dataArray[indexPath.row].1.0
            let height = dataArray[indexPath.row].1.1
            cropImageView.cropAspectRatio = CGFloat(width)/CGFloat(height)
        }
    }
    //MARK:- Button Tapped
    func backToLast()
    {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    func reset()
    {
        cropPhoto = photo
        cropImageView.toCropImage = cropPhoto
    }
    func cutting()
    {
        cropPhoto = cropImageView.currentCroppedImage()
        cropImageView.toCropImage = cropPhoto
    }
    func centerScrollViewContents() {
        let boundsSize = scrollImageView.bounds.size
        var contentsFrame = cropImageView.frame
        
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
        
        cropImageView.frame = contentsFrame
    }
}
extension CropViewController
{
    // MARK: - UIScrollViewDelegate
    override func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return cropImageView
    }
    
    override func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerScrollViewContents()
    }
    override func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat)
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
        let pointInView = recognizer.location(in: cropImageView)
        
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


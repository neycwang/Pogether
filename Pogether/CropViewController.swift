//
//  CropViewController.swift
//  Pogether
//
//  Created by KiraMelody on 2017/2/15.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import UIKit

class CropViewController: UICollectionViewController {

    var photoImageView: UIImageView!
    var photo: UIImage!
    var dataArray = [(Int, Int)]()
    var resetButton: UIButton!
    var cutButton: UIButton!
    var scrollImageView: UIScrollView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init()
    {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: UIScreen.main.bounds.height - 140, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        super.init(collectionViewLayout: layout)
        let height = self.view.frame.height
        let width = self.view.frame.width
        collectionView = UICollectionView(frame: CGRect(x: 0, y: height - 140, width: width, height: 80), collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.backgroundColor = ColorandFontTable.groundGray
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
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
        
        dataArray = [(48, 32), (36, 36), (24, 36), (36, 24), (27, 36), (18, 32)]
        
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
        
        photoImageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.width - 20, height: self.view.frame.height - 190)))
        photoImageView.image = photo
        photoImageView.contentMode = .scaleAspectFit
        scrollImageView.addSubview(photoImageView)
        
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
            make.width.equalTo(dataArray[indexPath.row].0)
            make.height.equalTo(dataArray[indexPath.row].1)
        }
        cell.titleLabel.text = "\(dataArray[indexPath.row].0) : \(dataArray[indexPath.row].1)"
        cell.backgroundColor = ColorandFontTable.primaryPink
        return cell
    }
    
    //MARK:- Button Tapped
    func backToLast()
    {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    func reset()
    {
        
    }
    func cutting()
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
extension CropViewController
{
    // MARK: - UIScrollViewDelegate
    override func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
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


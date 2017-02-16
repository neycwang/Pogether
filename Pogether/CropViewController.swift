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
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init()
    {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 69, height: 80)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 600, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        super.init(collectionViewLayout: layout)
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 80), collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.backgroundColor = ColorandFontTable.groundGray
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        self.collectionView!.register(CropCollectionViewCell.self, forCellWithReuseIdentifier: "CropCollectionViewCell")
        
        photoImageView = UIImageView(frame: self.view.frame)
        photoImageView.contentMode = .scaleAspectFit
        
        resetButton = UIButton(frame: CGRect(x: 20, y: 560, width: 70, height: 30))
        resetButton.addTarget(self, action: #selector(reset), for: .touchUpInside)
        resetButton.setTitle("重置", for: .normal)
        resetButton.setTitleColor(ColorandFontTable.textPink, for: .normal)
        resetButton.backgroundColor = UIColor.clear
        resetButton.layer.borderColor = ColorandFontTable.fillGray.cgColor
        resetButton.layer.cornerRadius = 15
        resetButton.layer.masksToBounds = true
        resetButton.layer.borderWidth = 2
        
        cutButton = UIButton(frame: CGRect(x: 324, y: 560, width: 70, height: 30))
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
        
        
        collectionView!.addSubview(photoImageView)
        collectionView!.addSubview(resetButton)
        collectionView!.addSubview(cutButton)
    }
    
    //MARK:- View Control
    override func viewWillAppear(_ animated: Bool) {
        photoImageView.image = photo
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

}

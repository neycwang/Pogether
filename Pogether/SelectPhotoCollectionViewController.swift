//
//  SelectPhotoCollectionViewController.swift
//  Pogether
//
//  Created by KiraMelody on 2017/2/18.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SelectPhotoCollectionViewController:  UICollectionViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var ImageArray = [UIImage?]()
    var lastSelect: IndexPath!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 30) / 3, height: (UIScreen.main.bounds.width - 30) / 3)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        super.init(collectionViewLayout: layout)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView!.delegate = self
        collectionView!.backgroundColor = ColorandFontTable.groundGray
        self.view.addSubview(collectionView!)
        self.collectionView!.register(SelectCollectionViewCell.self, forCellWithReuseIdentifier: "SelectCollectionViewCell")
        for _ in 1...20
        {
            ImageArray.append(#imageLiteral(resourceName: "default"))
        }
        
        var backImage = #imageLiteral(resourceName: "ContactList_Back")
        backImage = backImage.withRenderingMode(.alwaysOriginal)
        let backItem = UIBarButtonItem (image: backImage, style: .plain, target: self, action: #selector(backToLast))
        self.navigationItem.leftBarButtonItem = backItem
        
        let addButton = UIButton(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 46, width: UIScreen.main.bounds.width, height: 46))
        addButton.titleLabel?.isHidden = false
        addButton.setTitle("开始合成", for: .normal)
        addButton.setTitleColor(UIColor.white, for: .normal)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        addButton.backgroundColor = ColorandFontTable.primaryPink
        addButton.addTarget(self, action: #selector(backToLast), for: UIControlEvents.touchUpInside)
        self.view.addSubview(addButton)
        
        self.title = "选择素材"
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SelectCollectionViewCell
        cell.isAdded = !cell.isAdded
        if cell.isAdded {
            cell.selectView.image = #imageLiteral(resourceName: "Select_Yes")
        } else {
            cell.selectView.image = #imageLiteral(resourceName: "Select_None")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView!.cellForItem(at: indexPath) as! SelectCollectionViewCell
        
        cell.photoView.contentMode = .scaleAspectFit
        cell.indexPath = indexPath
        if (ImageArray[indexPath.row] != nil)
        {
            cell.photoView.image = ImageArray[indexPath.row]
            cell.photoView.contentMode = .scaleAspectFit
        }
        else
        {
            cell.photoView.image = nil
        }
        return cell
    }
    
    func backToLast()
    {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
}

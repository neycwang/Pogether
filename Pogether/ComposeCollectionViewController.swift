//
//  ComposeCollectionViewController.swift
//  Pogether
//
//  Created by KiraMelody on 2017/2/16.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import UIKit

class ComposeCollectionViewController: UICollectionViewController {
    var photoImageView: UIImageView!
    var photo: UIImage!
    var scrollImageView: UIScrollView!
    var resource = [UIImage]()
    var imageControl = [(IndexPath, UIImageView)]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init()
    {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: height - 160, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        super.init(collectionViewLayout: layout)
        collectionView = UICollectionView(frame: CGRect(x: 0, y: height - 160, width: width, height: 80), collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.backgroundColor = ColorandFontTable.groundGray
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.bounces = false
        self.collectionView!.register(SelectCollectionViewCell.self, forCellWithReuseIdentifier: "SelectCollectionViewCell")
        
        let add = UIBarButtonItem(title: "添加素材", style: .plain, target: self, action: #selector(addResource))
        let cancel = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Cancel"), style: .plain, target: self, action: #selector(backToLast))
        let save = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Save"), style: .plain, target: self, action: #selector(addResource))
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let barArray = [cancel, space, add, space, save]
        self.toolbarItems = barArray
        
        resource = [#imageLiteral(resourceName: "icon"),#imageLiteral(resourceName: "icon1"),#imageLiteral(resourceName: "Select_Yes"),#imageLiteral(resourceName: "Select_None")]
    }

    
    //MARK:- View Control
    override func viewWillAppear(_ animated: Bool) {
        let tagView = UIImageView()
        tagView.contentMode = .scaleAspectFit
        tagView.image = #imageLiteral(resourceName: "Resource_Title")
        collectionView!.addSubview(tagView)
        tagView.snp.makeConstraints { (make) in
            make.right.equalTo(self.view).offset(-2)
            make.bottom.equalTo(self.view).offset(-140)
            make.height.equalTo(20)
            make.width.equalTo(135)
        }
        photoImageView = UIImageView()
        photoImageView.image = photo
        photoImageView.contentMode = .scaleAspectFit
        self.view.addSubview(photoImageView)
        photoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(20)
            make.left.equalTo(self.view).offset(10)
            make.right.equalTo(self.view).offset(-10)
            make.bottom.equalTo(self.view).offset(-170)
        }
        self.navigationController?.setToolbarHidden(false, animated: false)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressHandler(sender:)))
        collectionView!.addGestureRecognizer(longPressGesture)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setToolbarHidden(true, animated: false)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return resource.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectCollectionViewCell", for: indexPath) as! SelectCollectionViewCell
        cell.photoView.image = resource[indexPath.row]
        cell.selectView.image = #imageLiteral(resourceName: "Select_None")
        cell.tag = indexPath.row
        // Configure the cell
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: sourceIndexPath)!
        var data = collectionView.visibleCells
        data.remove(at: sourceIndexPath.row)
        data.insert(cell, at: destinationIndexPath.row)
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SelectCollectionViewCell
        cell.isAdded = !cell.isAdded
        if cell.isAdded {
            cell.selectView.image = #imageLiteral(resourceName: "Select_Yes")
            let imageView = MovableImageView(image: cell.photoView.image)
            imageView.layer.borderColor = ColorandFontTable.primaryPink.cgColor
            imageView.layer.borderWidth = 1
            self.view.addSubview(imageView)
            imageControl.append((indexPath, imageView))
            
        } else {
            cell.selectView.image = #imageLiteral(resourceName: "Select_None")
            imageControl = imageControl.filter({ (index, imageView) -> Bool in
                if index == indexPath {
                    print(indexPath)
                    imageView.removeFromSuperview()
                    return false
                } else {
                    return true
                }
            })
        }
    }

    //MARK:- Button Tapped
    func backToLast()
    {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    func addResource()
    {
        let avc = SelectAlbumTableViewController()
        self.navigationController?.pushViewController(avc, animated: true)
    }
    
    func longPressHandler(sender: UILongPressGestureRecognizer)
    {
        let loc = sender.location(in: collectionView!)
        let index = collectionView!.indexPathForItem(at: loc)
        if index == nil
        {
            return
        }
        if sender.state == .began
        {
            collectionView!.beginInteractiveMovementForItem(at: index!)
            return
        }
        if sender.state == .ended
        {
            collectionView!.endInteractiveMovement()
            return
        }
        collectionView!.updateInteractiveMovementTargetPosition(loc)
    }
}

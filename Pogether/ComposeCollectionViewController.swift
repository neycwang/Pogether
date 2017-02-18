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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init()
    {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 500, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        super.init(collectionViewLayout: layout)
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 500, width: 414, height: 80), collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.backgroundColor = ColorandFontTable.groundGray
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        self.collectionView!.register(SelectCollectionViewCell.self, forCellWithReuseIdentifier: "SelectCollectionViewCell")
        
        let add = UIBarButtonItem(title: "添加素材", style: .plain, target: self, action: #selector(addResource))
        let cancel = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Cancel"), style: .plain, target: self, action: #selector(backToLast))
        let save = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Save"), style: .plain, target: self, action: #selector(addResource))
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let barArray = [cancel, space, add, space, save]
        self.toolbarItems = barArray
        
        photoImageView = UIImageView()
        photoImageView.contentMode = .scaleAspectFit
        collectionView!.addSubview(photoImageView)
        photoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(20)
            make.bottom.equalTo(self.view).offset(-170)
            make.left.equalTo(self.view).offset(10)
            make.right.equalTo(self.view).offset(-10)
        }
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
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectCollectionViewCell", for: indexPath) as! SelectCollectionViewCell
        cell.photoView.image = #imageLiteral(resourceName: "default")
        cell.selectView.image = #imageLiteral(resourceName: "Select_None")
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SelectCollectionViewCell
        cell.isAdded = !cell.isAdded
        if cell.isAdded {
            cell.selectView.image = #imageLiteral(resourceName: "Select_Yes")
        } else {
            cell.selectView.image = #imageLiteral(resourceName: "Select_None")
        }
    }

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
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

}

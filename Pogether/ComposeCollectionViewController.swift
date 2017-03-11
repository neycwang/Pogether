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
    var photo: UIImage! {
        didSet {
            if photoImageView != nil
            {
                photoImageView.image = photo
            }
        }
    }
    var resource = [UIImage]()
    var imageControl = [(UIImage, UIImageView)]()
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
        layout.minimumLineSpacing = 0
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
        let save = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Save"), style: .plain, target: self, action: #selector(saveToLast))
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let barArray = [cancel, space, add, space, save]
        self.toolbarItems = barArray
        
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            for i in 0..<resource.count
        {
            resource[i] = removeBackground(image: resource[i])
            let imageView = MovableImageView(image: resource[i])
            imageView.contentMode = .scaleAspectFit
            imageView.layer.borderColor = ColorandFontTable.primaryPink.cgColor
            imageView.layer.borderWidth = 1
            //imageView.addGestureRecognizer(tap)
            imageView.tag = i + 1
            imageControl.append((resource[i], imageView))
            imageControl[i].1.tag = i + 1
            imageControl[i].1.isHidden = true
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "照片合成"
        definesPresentationContext = true
        
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
        for i in 0..<resource.count
        {
            self.view.addSubview(imageControl[i].1)
        }
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
        return imageControl.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectCollectionViewCell", for: indexPath) as! SelectCollectionViewCell
        cell.photoView.image = imageControl[indexPath.row].0
        cell.selectView.image = #imageLiteral(resourceName: "Select_None")
        cell.setNeedsLayout()
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
        let move = resource.remove(at: sourceIndexPath.row)
        resource.insert(move, at: destinationIndexPath.row)
        var sourceIndex: Int = 0
        var destinationIndex: Int = 0
        for (index, subview) in self.view.subviews.enumerated()
        {
            if subview.tag == sourceIndexPath.row + 1 {
                sourceIndex = index
            }
            if subview.tag == destinationIndexPath.row + 1 {
                destinationIndex = index
            }
        }
        if sourceIndex != 0 && destinationIndex != 0 {
            let e = imageControl[sourceIndexPath.row]
            e.1.removeFromSuperview()
            self.view.insertSubview(e.1, at: destinationIndex)
        }
        
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SelectCollectionViewCell
        cell.isAdded = !cell.isAdded
        if cell.isAdded {
            cell.selectView.image = #imageLiteral(resourceName: "Select_Yes")
            imageControl[indexPath.row].1.isHidden = false

            
        } else {
            cell.selectView.image = #imageLiteral(resourceName: "Select_None")
            imageControl[indexPath.row].1.isHidden = true
        }
    }

    //MARK:- Button Tapped
    func backToLast()
    {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    func saveToLast()
    {
        for subview in self.view.subviews
        {
            if subview.tag > 0 {
                subview.layer.borderWidth = 0
            }
        }
        let rect = CGRect(x: 10, y: 20, width: self.view.frame.width - 20, height: self.view.frame.height - 200)
        UIGraphicsBeginImageContext(rect.size)
        self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let viewImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        definedAlbum["默认相册"]?.append(viewImage)
        backToLast()
    }

    func tapped(sender: UITapGestureRecognizer)
    {
        let loc = sender.location(in: view)
        for subview in self.view.subviews
        {
            if subview.tag > 0 {
                if subview.frame.contains(loc)
                {
                    subview.layer.borderWidth = 1
                } else
                {
                    subview.layer.borderWidth = 0
                }
            }
        }
    }
    func addResource()
    {
        let avc = SelectAlbumTableViewController()
        avc._delegate = self
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
    
    func removeBackground(image: UIImage) -> UIImage {
        let cubeMap = createCubeMap()
        let data = NSData(bytesNoCopy: cubeMap.data, length: Int(cubeMap.length), freeWhenDone: true)
        let colorCubeFilter = CIFilter(name: "CIColorCube")
        
        colorCubeFilter?.setValue(cubeMap.dimension, forKey: "inputCubeDimension")
        colorCubeFilter?.setValue(data, forKey: "inputCubeData")
        colorCubeFilter?.setValue(CIImage(image: image), forKey: kCIInputImageKey)
        return UIImage(ciImage: (colorCubeFilter?.outputImage)!)
    }
}

extension ComposeCollectionViewController: SelectPhotoDelegate
{
    func returnSelectedPhotos(indexPath: IndexPath, photos: [UIImage])
    {
        var indexs = [IndexPath]()
        for p in photos
        {
            self.resource.append(p)
        }
        print(self.resource.count)
        for i in self.resource.count - photos.count ..< self.resource.count
        {
            indexs.append([0,i])
            self.resource[i] = self.removeBackground(image: self.resource[i])
            let imageView = MovableImageView(image: self.resource[i])
            imageView.contentMode = .scaleAspectFit
            imageView.layer.borderColor = ColorandFontTable.primaryPink.cgColor
            imageView.layer.borderWidth = 1
            imageView.tag = i + 1
            self.imageControl.append((self.resource[i], imageView))
            self.imageControl[i].1.tag = i + 1
            self.view.addSubview(self.imageControl[i].1)
            self.imageControl[i].1.isHidden = true
        }
        self.collectionView?.performBatchUpdates({
            
            self.collectionView?.insertItems(at: indexs)
        }, completion: nil)
    }
}

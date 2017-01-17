//
//  PhotoCollectionViewController.swift
//  Pogether
//
//  Created by KiraMelody on 2017/1/17.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import UIKit

class PhotoCollectionViewController:  UICollectionViewController, UINavigationControllerDelegate, PhotoCollectionViewCellDelegate, UIImagePickerControllerDelegate {

    var ImageArray = [UIImage?]()
    var lastSelect: IndexPath!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        super.init(collectionViewLayout: layout)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView!.delegate = self
        collectionView!.backgroundColor = UIColor.white
        self.view.addSubview(collectionView!)
        self.collectionView!.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        for _ in 1...9
        {
            ImageArray.append(nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "<九宫格>"
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 9
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        willAddImage(indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView!.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.photoView.contentMode = .scaleAspectFit
        cell.delegate = self
        cell.indexPath = indexPath
        if (ImageArray[indexPath.row] != nil)
        {
            cell.photoView.image = ImageArray[indexPath.row]
            cell.photoView.contentMode = .scaleAspectFit
            cell.addButton.isHidden = true
        }
        else
        {
            cell.photoView.image = nil
            cell.addButton.isHidden = false
        }
        return cell
    }
    
    func willAddImage (_ indexPath: IndexPath)
    {
        let picker = UIImagePickerController()
        picker.delegate = self
        let actions = UIAlertController(title: "提示", message: "选取或拍摄照片", preferredStyle: UIAlertControllerStyle.actionSheet)
        let action1 = UIAlertAction(title: "在图库中选取", style: UIAlertActionStyle.default) { (action) in
            self.navigationController!.present(picker, animated: true, completion: nil)
        }
        let action2 = UIAlertAction(title: "拍照", style: UIAlertActionStyle.default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
            {
                picker.sourceType = .camera
                self.navigationController!.present(picker, animated: true, completion: nil)
            }
            else
            {
                print ("不支持相机")
            }
            
        }
        let action3 = UIAlertAction(title: "取消", style: .cancel) { (action) in Void() }
        actions.addAction(action1)
        actions.addAction(action2)
        actions.addAction(action3)
        lastSelect = indexPath
        self.navigationController!.present(actions, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let selectImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        ImageArray[lastSelect.row] = selectImage
        picker.dismiss(animated: true, completion: nil)
        collectionView?.reloadItems(at: [lastSelect])
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}

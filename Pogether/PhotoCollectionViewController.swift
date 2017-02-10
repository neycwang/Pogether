//
//  PhotoCollectionViewController.swift
//  Pogether
//
//  Created by KiraMelody on 2017/1/17.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import UIKit
import YCXMenu

class PhotoCollectionViewController:  UICollectionViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var ImageArray = [UIImage?]()
    var lastSelect: IndexPath!
    var menuItems = [YCXMenuItem]()
    
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
        self.collectionView!.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        for _ in 1...20
        {
            ImageArray.append(#imageLiteral(resourceName: "default"))
        }
        var setImage = #imageLiteral(resourceName: "PhotoList_Setting")
        setImage = setImage.withRenderingMode(.alwaysOriginal)
        let setItem = UIBarButtonItem (image: setImage, style: .plain, target: self, action: #selector(showSettings))
        self.navigationItem.rightBarButtonItem = setItem
        
        var backImage = #imageLiteral(resourceName: "ContactList_Back")
        backImage = backImage.withRenderingMode(.alwaysOriginal)
        let backItem = UIBarButtonItem (image: backImage, style: .plain, target: self, action: #selector(backToLast))
        self.navigationItem.leftBarButtonItem = backItem
        
        let addButton = UIButton(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 46, width: UIScreen.main.bounds.width, height: 46))
        addButton.titleLabel?.isHidden = false
        addButton.setTitle("添加", for: .normal)
        addButton.setTitleColor(UIColor.white, for: .normal)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        addButton.backgroundColor = ColorandFontTable.primaryPink
        addButton.addTarget(self, action: #selector(addNewPhoto), for: UIControlEvents.touchUpInside)
        self.view.addSubview(addButton)
    }
    
    func setMenu()
    {
        menuItems.append(YCXMenuItem())
        menuItems[0].title = "所有人可见"
        menuItems[0].target = self
        menuItems[0].foreColor = UIColor.black
        print(menuItems[0].enabled())
        
        menuItems[0].performAction()
        menuItems[0].action = #selector(setAuthority)
        
        menuItems.append(YCXMenuItem())
        menuItems[1].title = "仅自己可见"
        menuItems[1].target = self
        menuItems[1].foreColor = UIColor.black
        menuItems[1].action = #selector(setAuthority)
        
        menuItems.append(YCXMenuItem())
        menuItems[2].title = "部分可见"
        menuItems[2].target = self
        menuItems[2].foreColor = UIColor.black
        menuItems[2].action = #selector(setAuthority)
        
        menuItems.append(YCXMenuItem())
        menuItems[3].title = "部分不可见"
        menuItems[3].target = self
        menuItems[3].foreColor = UIColor.black
        menuItems[3].action = #selector(setAuthority)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "默认相册"
        setMenu()
    }
    
    func showSettings ()
    {
        YCXMenu.setTintColor(UIColor.white)
        YCXMenu.setSelectedColor(ColorandFontTable.selectedGray)
        YCXMenu.setSeparatorColor(ColorandFontTable.lineBlack)
        YCXMenu.show(in: self.view, from: CGRect(x: 325, y: 0, width: 45, height: 64), menuItems: menuItems, selected: { (index, item) in
            print(index, item?.title!)
        })
        
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
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView!.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell

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
    
    func backToLast()
    {
        self.navigationController?.popViewController(animated: true)
    }
    func setAuthority()
    {
        print("click")
    }
    func addNewPhoto()
    {
        
    }

}

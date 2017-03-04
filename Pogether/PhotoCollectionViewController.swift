//
//  PhotoCollectionViewController.swift
//  Pogether
//
//  Created by KiraMelody on 2017/1/17.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import UIKit
import YCXMenu
protocol EditLimit: NSObjectProtocol {
    func editLimit(count: Int, limit: Limit?)
}

class PhotoCollectionViewController:  UICollectionViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var ImageArray = [UIImage?]()
    var menuItems = [YCXMenuItem]()
    var isSetting = true
    var addButton: UIButton!
    var indexPath: IndexPath!
    var limit: Limit? = nil
    weak var _delegate: EditLimit?
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
            ImageArray.append(#imageLiteral(resourceName: "Homepage_Background"))
        }
        
        var backImage = #imageLiteral(resourceName: "ContactList_Back")
        backImage = backImage.withRenderingMode(.alwaysOriginal)
        let backItem = UIBarButtonItem (image: backImage, style: .plain, target: self, action: #selector(backToLast))
        self.navigationItem.leftBarButtonItem = backItem
        
        var setImage = #imageLiteral(resourceName: "PhotoList_Setting")
        setImage = setImage.withRenderingMode(.alwaysOriginal)
        let setItem = UIBarButtonItem (image: setImage, style: .plain, target: self, action: #selector(showSettings))
        self.navigationItem.rightBarButtonItem = setItem
        
        addButton = UIButton(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 46, width: UIScreen.main.bounds.width, height: 46))
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
        menuItems.append(YCXMenuItem("所有人可见", image: UIImage(), target: self, action: #selector(setAll)))
        menuItems.append(YCXMenuItem("仅自己可见", image: UIImage(), target: self, action: #selector(setMyself)))
        menuItems.append(YCXMenuItem("部分可见", image: UIImage(), target: self, action: #selector(setSome)))
        menuItems.append(YCXMenuItem("部分不可见", image: UIImage(), target: self, action: #selector(setSomeNot)))
        
        for item in menuItems
        {
            item.foreColor = UIColor.black
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "默认相册"
        if isSetting
        {
            setMenu()
        }
    }
    
    func showSettings ()
    {
        YCXMenu.setTintColor(UIColor.white)
        YCXMenu.setSelectedColor(ColorandFontTable.selectedGray)
        YCXMenu.setSeparatorColor(ColorandFontTable.lineBlack)
        
        YCXMenu.show(in: self.view, from: CGRect(x: 325, y: 0, width: 45, height: 64), menuItems: menuItems, selected: { (index, item) in
            
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        if !isSetting {
            addButton.removeFromSuperview()
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return ImageArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = self.collectionView?.cellForItem(at: indexPath) as! PhotoCollectionViewCell
        let pvc = PresentationViewController()
        pvc.canDelete = isSetting
        pvc.photo = ImageArray[indexPath.row]
        pvc.indexPath = indexPath
        pvc.delegate = self
        pvc._delegate = cell
        self.navigationController?.pushViewController(pvc, animated: true)
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

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let selectImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let avc = EditViewController()
        avc.photo = selectImage
        self.navigationController?.pushViewController(avc, animated: true)
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func backToLast()
    {
        self._delegate?.editLimit(count: ImageArray.count, limit: limit)
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - set authority
    var selectedContacts = [Account]()
    func setAll()
    {
        self._delegate?.editLimit(count: ImageArray.count, limit: .all)
    }
    func setMyself()
    {
        self._delegate?.editLimit(count: ImageArray.count, limit: .myself)
    }
    func setSome()
    {
        self._delegate?.editLimit(count: ImageArray.count, limit: .somecan)
        let avc = SelectContactTableViewController()
        avc.delegate = self
        avc.returnSelected = selectedContacts
        self.navigationController?.pushViewController(avc, animated: true)
    }
    func setSomeNot()
    {
        self._delegate?.editLimit(count: ImageArray.count, limit: .somenot)
        let avc = SelectContactTableViewController()
        avc.delegate = self
        avc.returnSelected = selectedContacts
        self.navigationController?.pushViewController(avc, animated: true)
    }
    func addNewPhoto()
    {
        let picker = UIImagePickerController()
        picker.delegate = self
        self.navigationController!.present(picker, animated: true, completion: nil)
    }

}

extension PhotoCollectionViewController: SelectContactDelegate
{
    func returnSelectedContacts(returnSelected: [Account])
    {
        self.selectedContacts = returnSelected
    }
}

extension PhotoCollectionViewController: DeletePhoto
{
    func delegePhoto(indexPath: IndexPath) {
        ImageArray.remove(at: indexPath.row)
        collectionView?.reloadData()
        backToLast()
    }
}

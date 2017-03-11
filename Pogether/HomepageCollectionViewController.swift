//
//  HomepageCollectionViewController.swift
//  Pogether
//
//  Created by KiraMelody on 2017/2/4.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import UIKit
fileprivate class Function {
    var name: String?
    var image: UIImage?
    var color: UIColor?
    init(name: String, image: UIImage, color: UIColor)
    {
        self.name = name
        self.image = image
        self.color = color
    }
}
class HomepageCollectionViewController: UICollectionViewController, UINavigationControllerDelegate {

    fileprivate var FunctionArray = [Function?]()
    var posterView: UIImageView!
    var settingButton: UIButton!
    var width, height: CGFloat!
    var isCompose = true
    init() {
        width = UIScreen.main.bounds.width
        height = UIScreen.main.bounds.height
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: height - 300, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: width * 0.4, height: width * 0.24)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 15
        super.init(collectionViewLayout: layout)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView!.delegate = self
        let bgImage = UIImage(cgImage: #imageLiteral(resourceName: "Homepage_Background").cgImage!, scale: 600 / height, orientation: .up)
        collectionView!.backgroundColor = UIColor(patternImage: bgImage)
        self.view.addSubview(collectionView!)
        self.collectionView!.register(HomepageCollectionViewCell.self, forCellWithReuseIdentifier: "HomepageCollectionViewCell")
        FunctionArray.append(Function(name: "组合", image: #imageLiteral(resourceName: "Homepage_Group"), color: UIColor(red: 165 / 255, green: 222 / 255, blue: 55 / 255, alpha: 1)))
        FunctionArray.append(Function(name: "朋友", image: #imageLiteral(resourceName: "Homepage_Friend"), color: UIColor(red: 255 / 255, green: 67 / 255, blue: 81 / 255, alpha: 1)))
        FunctionArray.append(Function(name: "拍照", image: #imageLiteral(resourceName: "Homepage_Screenshot"), color: UIColor(red: 123 / 255, green: 114 / 255, blue: 233 / 255, alpha: 1)))
        FunctionArray.append(Function(name: "素材", image: #imageLiteral(resourceName: "Homepage_Resource"), color: UIColor(red: 254 / 255, green: 174 / 255, blue: 27 / 255, alpha: 1)))
        
        posterView = UIImageView()
        posterView.image = #imageLiteral(resourceName: "Homepage_Poster")
        posterView.contentMode = .scaleAspectFit
        settingButton = UIButton()
        settingButton.setImage(#imageLiteral(resourceName: "Homepage_Setting"), for: .normal)
        settingButton.addTarget(self, action: #selector(setting), for: .touchUpInside)
        collectionView!.addSubview(posterView)
        collectionView!.addSubview(settingButton)
        posterView.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(view).offset(20)
            make.height.equalTo(view).dividedBy(2)
        }
        settingButton.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(32)
            make.right.equalTo(view).offset(-32)
            make.height.equalTo(32)
            make.width.equalTo(32)
        }
        
        definedAlbum ["默认相册"] = [#imageLiteral(resourceName: "人物1"), #imageLiteral(resourceName: "人物2")]
        
        definedAlbum ["背景图片"] = [#imageLiteral(resourceName: "长城"), #imageLiteral(resourceName: "云海"),#imageLiteral(resourceName: "雪原"),#imageLiteral(resourceName: "天宫"),#imageLiteral(resourceName: "桃花林"),#imageLiteral(resourceName: "山路"),#imageLiteral(resourceName: "森林"),#imageLiteral(resourceName: "海滩"),#imageLiteral(resourceName: "桂林"),#imageLiteral(resourceName: "草原")]
        
        definedAlbum ["Pogether 数据库"] = [#imageLiteral(resourceName: "表情包1"),#imageLiteral(resourceName: "表情包2"),#imageLiteral(resourceName: "表情包3"),#imageLiteral(resourceName: "表情包4"),#imageLiteral(resourceName: "表情包5"),#imageLiteral(resourceName: "表情包6"),#imageLiteral(resourceName: "表情包7"),#imageLiteral(resourceName: "表情包8"),#imageLiteral(resourceName: "表情包9"),#imageLiteral(resourceName: "表情包10")]
        
        definedAlbum ["个人收藏"] = [UIImage]()
        
        definedContact["T"] = [Account(username: "童佳琪1"),Account(username: "童佳琪2"),Account(username: "童佳琪3")]
        definedContact["W"] = [Account(username: "王禹程"),Account(username: "王沛晟")]
        definedContact["H"] = [Account(username: "胡天晓")]
        definedContact["L"] = [Account(username: "兰石懿")]
        definedContact["Z"] = [Account(username: "张昊晗")]

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: Data Source
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FunctionArray.count
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath {
        case [0,0]:
            let picker = UIImagePickerController()
            isCompose = true
            picker.delegate = self
            self.navigationController!.present(picker, animated: true, completion: { 
                
            })
        case [0,1]:
            jumpTo(page: ContactTableViewController())
        case [0,2]:
            let picker = UIImagePickerController()
            isCompose = false
            picker.delegate = self
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
            {
                picker.sourceType = .camera
                self.navigationController!.present(picker, animated: true, completion: nil)
            }
            else
            {
                NSLog("不支持相机")
            }
        case [0,3]:
            jumpTo(page: AlbumTableViewController())
        default:
            break
        }
    }
    //MARK: Cell Setting
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView!.dequeueReusableCell(withReuseIdentifier: "HomepageCollectionViewCell", for: indexPath) as! HomepageCollectionViewCell
        
        cell.iconView.contentMode = .scaleAspectFit
        if FunctionArray[indexPath.row] != nil
        {
            cell.iconView.image = FunctionArray[indexPath.row]?.image
            cell.descLabel.text = FunctionArray[indexPath.row]?.name
            cell.backgroundColor = FunctionArray[indexPath.row]?.color
        }
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 20),NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.backgroundColor = ColorandFontTable.primaryPink
        self.navigationController?.navigationBar.barTintColor = ColorandFontTable.primaryPink
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.isHidden = true
        
        self.navigationController?.toolbar.backgroundColor = ColorandFontTable.primaryPink
        self.navigationController?.toolbar.barStyle = .default
        self.navigationController?.toolbar.barTintColor = ColorandFontTable.primaryPink
        self.navigationController?.toolbar.tintColor = UIColor.white
    }
    
    func jumpTo(page: NSObject)
    {
        navigationController?.pushViewController(page as! UIViewController, animated: true)
    }
    func setting()
    {
        let avc = ProfileViewController()
        avc.isSetting = true
        avc.isStranger = false
        navigationController?.pushViewController(avc, animated: false)
    }
    
}

extension HomepageCollectionViewController: UIImagePickerControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        var selectImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imageOrientation = selectImage.imageOrientation
        if imageOrientation != UIImageOrientation.up
        {
            UIGraphicsBeginImageContext(selectImage.size);
            selectImage.draw(in: CGRect(x: 0, y: 0, width: selectImage.size.width, height: selectImage.size.height))
            selectImage = UIGraphicsGetImageFromCurrentImageContext()!;
            UIGraphicsEndImageContext();
        }
        if isCompose {
            let avc = ComposeCollectionViewController()
            avc.photo = selectImage
            navigationController?.pushViewController(avc, animated: true)
        } else {
            let avc = PresentationViewController()
            avc.photo = selectImage
            avc.canDelete = false
            avc.isNew = true
            navigationController?.pushViewController(avc, animated: true)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
    }
}

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
class HomepageCollectionViewController: UICollectionViewController {

    fileprivate var FunctionArray = [Function?]()
    var posterView: UIImageView!
    var settingView: UIImageView!
    var width, height: CGFloat!

    init() {
        width = UIScreen.main.bounds.width
        height = UIScreen.main.bounds.height
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 380, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: width * 0.437, height: 100)
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
        settingView = UIImageView()
        posterView.image = #imageLiteral(resourceName: "Homepage_Poster")
        settingView.image = #imageLiteral(resourceName: "Homepage_Setting")
        posterView.contentMode = .scaleAspectFit
        settingView.contentMode = .scaleAspectFit
        collectionView!.addSubview(posterView)
        collectionView!.addSubview(settingView)
        posterView.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(view).offset(20)
            make.height.equalTo(view).dividedBy(2)
        }
        settingView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(32)
            make.right.equalTo(view).offset(-32)
            make.height.equalTo(32)
            make.width.equalTo(32)
        }

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
            jumpTo(page: PhotoCollectionViewController())
        case [0,1]:
            jumpTo(page: ContactTableViewController())
        case [1,0]:
            jumpTo(page: PhotoCollectionViewController())
        case [1,1]:
            jumpTo(page: PhotoCollectionViewController())
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
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func jumpTo(page: NSObject)
    {
        navigationController?.pushViewController(page as! UIViewController, animated: true)
    }
    
}

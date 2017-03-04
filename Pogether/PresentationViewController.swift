//
//  PresentationViewController.swift
//  Pogether
//
//  Created by KiraMelody on 2017/2/12.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import UIKit
protocol DeletePhoto: NSObjectProtocol {
    func delegePhoto(indexPath: IndexPath)
}

class PresentationViewController: ScrollImageViewController {

    var canDelete: Bool = false
    var indexPath: IndexPath!
    weak var delegate: DeletePhoto?
    func initialize()
    {
        if canDelete
        {
            let deleteItem = UIBarButtonItem (title: "删除", style: .plain, target: self, action: #selector(deletePhoto))
            self.navigationItem.rightBarButtonItem = deleteItem
        }
        var backImage = #imageLiteral(resourceName: "ContactList_Back")
        backImage = backImage.withRenderingMode(.alwaysOriginal)
        let backItem = UIBarButtonItem (image: backImage, style: .plain, target: self, action: #selector(backToLast))
        self.navigationItem.leftBarButtonItem = backItem
        
        let addButton = UIButton(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 46, width: UIScreen.main.bounds.width, height: 46))
        addButton.titleLabel?.isHidden = false
        addButton.setTitleColor(UIColor.white, for: .normal)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        addButton.backgroundColor = ColorandFontTable.primaryPink
        if canDelete
        {
            addButton.setTitle("编辑", for: .normal)
            addButton.addTarget(self, action: #selector(editPhoto), for: UIControlEvents.touchUpInside)
        } else {
            addButton.setTitle("收藏", for: .normal)
            addButton.addTarget(self, action: #selector(storePhoto), for: UIControlEvents.touchUpInside)
        }
        self.view.addSubview(addButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        self.title = "详情"
        self.view.backgroundColor = ColorandFontTable.groundGray
        super.setScrollView()
        scrollImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(70)
            make.bottom.equalTo(self.view).offset(-50)
            make.left.equalTo(self.view).offset(10)
            make.right.equalTo(self.view).offset(-10)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        centerScrollViewContents()
        self.navigationController?.setToolbarHidden(true, animated: false)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backToLast()
    {
        self.delegate?.delegePhoto(indexPath: self.indexPath)
        let _ = self.navigationController?.popViewController(animated: true)
    }

    func deletePhoto()
    {
        let delete = UIAlertAction(title: "删除照片", style: UIAlertActionStyle.default) { (UIAlertAction) in
            self.delegate?.delegePhoto(indexPath: self.indexPath)
            return
        }
        let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) { (UIAlertAction) in
            return
        }
        let alert = UIAlertController(title: "您将删除本张照片", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(delete)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    func editPhoto()
    {
        let evc = EditViewController()
        evc.photo = self.photo
        self.navigationController?.pushViewController(evc, animated: true)
    }
    func storePhoto()
    {
        
    }
}

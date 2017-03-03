//
//  EditViewController.swift
//  Pogether
//
//  Created by KiraMelody on 2017/2/12.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import UIKit

class EditViewController: ScrollImageViewController {
    
    func initialize()
    {
        var backImage = #imageLiteral(resourceName: "ContactList_Back")
        backImage = backImage.withRenderingMode(.alwaysOriginal)
        let backItem = UIBarButtonItem (image: backImage, style: .plain, target: self, action: #selector(backToLast))
        self.navigationItem.leftBarButtonItem = backItem
        
        let crop = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Edit"), style: .plain, target: self, action: #selector(jumpToCrop))
        let augment = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Augment"), style: .plain, target: self, action: #selector(jumpToAugment))
        let matting = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Matting"), style: .plain, target: self, action: #selector(jumpToMatting))
        let text = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Text"), style: .plain, target: self, action: #selector(jumpToText))
        let erase = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Erase"), style: .plain, target: self, action: #selector(jumpToErase))
        let cancel = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Cancel"), style: .plain, target: self, action: #selector(backToLast))
        let save = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Save"), style: .plain, target: self, action: #selector(backToLast))
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let barArray = [cancel, space, crop, space, augment, space, matting, space, text, space, erase, space, save]
        self.toolbarItems = barArray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        self.title = "编辑"
        self.view.backgroundColor = ColorandFontTable.groundGray
        self.automaticallyAdjustsScrollViewInsets = false
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
        self.navigationController?.setToolbarHidden(false, animated: false)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backToLast()
    {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    func jumpToCrop()
    {
        let avc = CropViewController()
        avc.photo = self.photo
        self.navigationController?.pushViewController(avc, animated: false)
    }
    func jumpToAugment()
    {
        let avc = AugmentViewController()
        avc.photo = self.photo
        self.navigationController?.pushViewController(avc, animated: false)
    }
    func jumpToMatting()
    {
        let avc = MattingViewController()
        avc.photo = self.photo
        self.navigationController?.pushViewController(avc, animated: false)
    }
    func jumpToText()
    {
        let avc = TextViewController()
        avc.photo = self.photo
        self.navigationController?.pushViewController(avc, animated: false)
    }
    func jumpToErase()
    {
        let avc = EraseViewController()
        avc.photo = self.photo
        self.navigationController?.pushViewController(avc, animated: false)
    }
    func editPhoto()
    {
        
    }
    func storePhoto()
    {
        
    }
    
}

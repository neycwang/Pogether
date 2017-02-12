//
//  EditViewController.swift
//  Pogether
//
//  Created by KiraMelody on 2017/2/12.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    var photoImageView: UIImageView!
    var photo: UIImage!
    var inputToolBar: UIToolbar!
    
    func initialize()
    {
        var backImage = #imageLiteral(resourceName: "ContactList_Back")
        backImage = backImage.withRenderingMode(.alwaysOriginal)
        let backItem = UIBarButtonItem (image: backImage, style: .plain, target: self, action: #selector(backToLast))
        self.navigationItem.leftBarButtonItem = backItem
        
        photoImageView = UIImageView(frame: self.view.frame)
        photoImageView.contentMode = .scaleAspectFit
        photoImageView.image = photo
        
        let edit = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Edit"), style: .plain, target: self, action: #selector(backToLast))
        let augment = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Augment"), style: .plain, target: self, action: #selector(backToLast))
        let matting = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Matting"), style: .plain, target: self, action: #selector(backToLast))
        let text = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Text"), style: .plain, target: self, action: #selector(backToLast))
        let cancel = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Cancel"), style: .plain, target: self, action: #selector(backToLast))
        let preserve = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Preserve"), style: .plain, target: self, action: #selector(backToLast))
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let barArray = [cancel, space, edit, space, augment, space, matting, space, text, space, preserve]
        self.toolbarItems = barArray
        //inputToolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 52, width: UIScreen.main.bounds.width, height: 52))
        //inputToolBar.tintColor = UIColor.white
        //inputToolBar.backgroundColor = ColorandFontTable.primaryPink
        //inputToolBar.barStyle = .default
        //inputToolBar.setItems(barArray, animated: false)
        //self.view.addSubview(inputToolBar)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        self.title = "编辑"
        self.view.addSubview(photoImageView)
        self.view.backgroundColor = ColorandFontTable.groundGray
        self.navigationController?.setToolbarHidden(false, animated: false)
        self.navigationController?.toolbar.backgroundColor = ColorandFontTable.primaryPink
        self.navigationController?.toolbar.barStyle = .default
        self.navigationController?.toolbar.barTintColor = ColorandFontTable.primaryPink
        self.navigationController?.toolbar.tintColor = UIColor.white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backToLast()
    {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    func editPhoto()
    {
        
    }
    func storePhoto()
    {
        
    }
    
}


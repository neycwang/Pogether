//
//  AlbumTableViewController.swift
//  Pogether
//
//  Created by KiraMelody on 2017/1/17.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import UIKit

class AlbumTableViewController: UITableViewController {
    
    var albumString = ["默认相册","背景图片","Pogether 数据库","个人收藏"]
    var securityString = ["仅自己可见","部分可见","部分不可见","对所有人可见"]
    var securityArray = [0,1,3,1]
    var albumPhotosCountArray = [100,100,60,50]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set properties
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = 70
        tableView.delegate = self
        tableView.backgroundColor = ColorandFontTable.groundGray
        tableView.dataSource = self
        tableView.sectionIndexColor = ColorandFontTable.primaryPink
        tableView.sectionIndexBackgroundColor = UIColor.clear
        tableView.tableFooterView = UIView(frame: .zero)
        
        //set navigation bar
        self.title = "素材库"
        initialize()
        registerForCell()
    }
    
    //show navigation bar
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func initialize(){
        //set navigation item
        var backImage = #imageLiteral(resourceName: "ContactList_Back")
        backImage = backImage.withRenderingMode(.alwaysOriginal)
        let backItem = UIBarButtonItem (image: backImage, style: .plain, target: self, action: #selector(backToLast))
        self.navigationItem.leftBarButtonItem = backItem
        
        var addImage = #imageLiteral(resourceName: "Album_Add")
        addImage = addImage.withRenderingMode(.alwaysOriginal)
        let addAlbum = UIBarButtonItem (image: addImage, style: .plain, target: self, action: #selector(AlbumTableViewController.jumpToProfile))
        self.navigationItem.rightBarButtonItem = addAlbum
    }
    
    func registerForCell() {
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: "AlbumTableViewCell")
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return albumString.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //set cell texts
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell", for: indexPath) as! AlbumTableViewCell
        cell.albumNameLabel.text = albumString[indexPath.row]
        cell.securityLabel.text = securityString[securityArray[indexPath.row]]
        cell.countLabel.text = " (\(albumPhotosCountArray[indexPath.row]))"
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let avc = PhotoCollectionViewController()
        self.navigationController?.pushViewController(avc, animated: false)
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete)
        {
            print("delete \(indexPath.row)")
        }
    }
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    func backToLast() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func jumpToProfile() {
        let avc = ProfileViewController()
        self.navigationController?.pushViewController(avc, animated: false)
    }
}

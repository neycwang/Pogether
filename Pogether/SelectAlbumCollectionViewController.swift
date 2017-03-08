//
//  SelectAlbumCollectionViewController.swift
//  Pogether
//
//  Created by KiraMelody on 2017/2/18.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import UIKit

class SelectAlbumTableViewController: UITableViewController {
    
    var albumArray = [Album]()
    var selectedPhotos = [UIImage]()
    weak var _delegate: SelectPhotoDelegate?
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
        tableView.bounces = false
        
        //set navigation bar
        self.title = "添加素材"
        initialize()
        registerForCell()
        self.navigationController?.navigationBar.isHidden = false
        
        albumArray = [Album(name: "默认相册", count: 50, limit: Limit.all), Album(name: "背景图片", count: 50, limit: Limit.myself), Album(name: "Pogether 数据库", count: 50, limit: Limit.somecan), Album(name: "个人收藏", count: 50, limit: Limit.somenot)]
        
    }
    
    //show navigation bar
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setToolbarHidden(true, animated: false)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func initialize(){
        //set navigation item
        var backImage = #imageLiteral(resourceName: "ContactList_Back")
        backImage = backImage.withRenderingMode(.alwaysOriginal)
        let backItem = UIBarButtonItem (image: backImage, style: .plain, target: self, action: #selector(backToLast))
        self.navigationItem.leftBarButtonItem = backItem
        
        let addButton = UIButton(frame: CGRect(x: 0, y: self.view.frame.height - 90, width: self.view.frame.width, height: 46))
        addButton.titleLabel?.isHidden = false
        addButton.setTitle("开始合成", for: .normal)
        addButton.setTitleColor(UIColor.white, for: .normal)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        addButton.backgroundColor = ColorandFontTable.primaryPink
        addButton.addTarget(self, action: #selector(backToLast), for: UIControlEvents.touchUpInside)
        self.view.addSubview(addButton)
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
        return albumArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //set cell texts
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell", for: indexPath) as! AlbumTableViewCell
        cell.album = albumArray[indexPath.row]
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let avc = SelectPhotoCollectionViewController()
        avc.delegate = self
        avc.indexPath = indexPath
        self.navigationController?.pushViewController(avc, animated: false)
    }

    func backToLast() {
        self._delegate?.returnSelectedPhotos(indexPath: [0,0], photos: selectedPhotos)
        let _ = self.navigationController?.popViewController(animated: true)
    }
}

extension SelectAlbumTableViewController: SelectPhotoDelegate
{
    func returnSelectedPhotos(indexPath: IndexPath, photos: [UIImage])
    {
        if photos.count > 0 {
            for p in photos
            {
                selectedPhotos.append(p)
            }
            let cell = tableView.cellForRow(at: indexPath) as! AlbumTableViewCell
            cell.select = photos.count
        }
    }
}

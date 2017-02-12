//
//  ContactTableViewController.swift
//  Pogether
//
//  Created by KiraMelody on 2017/2/5.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import UIKit

class ContactTableViewController: UITableViewController {
    var searchController = UISearchController()
    
    var contacts: [String : [Account]] = [:] {
        didSet {
            self.updatefilteredContacts()
        }
    }
    
    var sectionIndex: [String] = []
    
    private var filteredContacts: [String : [Account]] = [:]
    
    /*传入数据
     ['A':["哎哎哎"],
     'B':["啵啵啵"]]
     */
    var dataSource = ContactDataSource()
    
    func initialize()
    {
        var addImage = #imageLiteral(resourceName: "ContactList_Add")
        addImage = addImage.withRenderingMode(.alwaysOriginal)
        let addItem = UIBarButtonItem (image: addImage, style: .plain, target: self, action: #selector(addNewContact))
        self.navigationItem.rightBarButtonItem = addItem
        
        var backImage = #imageLiteral(resourceName: "ContactList_Back")
        backImage = backImage.withRenderingMode(.alwaysOriginal)
        let backItem = UIBarButtonItem (image: backImage, style: .plain, target: self, action: #selector(backToLast))
        self.navigationItem.leftBarButtonItem = backItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        
        tableView.estimatedRowHeight = 56
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.delegate = self
        tableView.backgroundColor = ColorandFontTable.groundGray
        tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: "ContactTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionIndexColor = ColorandFontTable.primaryPink
        tableView.sectionIndexBackgroundColor = UIColor.clear
        tableView.tableFooterView = UIView(frame: .zero)
        
        self.title = "通讯录"

        self.searchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.hidesNavigationBarDuringPresentation = false
            controller.dimsBackgroundDuringPresentation = true
            controller.searchBar.searchBarStyle = .minimal
            controller.searchBar.sizeToFit()
            controller.searchBar.removeFromSuperview()
            controller.delegate = self
            return controller
        })()
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: self.searchController.searchBar.frame.height + 2))
        header.backgroundColor = ColorandFontTable.groundGray
        header.addSubview(self.searchController.searchBar)
        tableView.tableHeaderView = header
        self.searchController.searchBar.isHidden = false
        self.searchController.searchBar.placeholder = "搜索"
        self.searchController.searchBar.tintColor = ColorandFontTable.textPink
        self.searchController.searchBar.barTintColor = UIColor.white
        self.searchController.searchBar.backgroundColor = ColorandFontTable.groundPink
        /*
        for i in 0...4
        {
            contacts["\(Character(UnicodeScalar(65 + i)!))"] = []
        }
        */
        contacts["A"] = [Account(id: "1", username: "aaa"), Account(id: "4", username: "aba"), Account(id: "5", username: "aca"), Account(id: "6", username: "aac"), Account(id: "7", username: "acc")]
        contacts["B"] = [Account(id: "2", username: "bbb")]
        contacts["C"] = [Account(id: "3", username: "ccc")]
        //NotificationCenter.defaultCenter().removeObserver(self, name: NOTIFICATION_TOKEN_EXPIRED, object: nil)
        //NotificationCenter.defaultCenter().addObserver(self, selector: #selector(tokenExpired), name: NOTIFICATION_TOKEN_EXPIRED, object: nil)
    }
    
    //MARK: - SearchBar
    
    func updatefilteredContacts() {
        filteredContacts = [:]
        for e in contacts
        {
            for i in e.value
            {
                if (!searchController.isActive
                    ||
                    (i.username?.lowercased().contains(searchController.searchBar.text!.lowercased()))!
                    ||
                    (searchController.isActive && searchController.searchBar.text! == ""))
                {
                    if filteredContacts[e.key] == nil
                    {
                        filteredContacts[e.key] = [Account]()
                    }
                    filteredContacts[e.key]!.append(i)
                }
            }
        }
        sectionIndex = Array(filteredContacts.keys).sorted(by: <)
        tableView.reloadData()
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionIndex.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredContacts[sectionIndex[section]] != nil {
            return filteredContacts[sectionIndex[section]]!.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 22
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let ground = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 22))
        let title = UILabel()
        title.text = sectionIndex[section]
        title.textColor = ColorandFontTable.textPink
        title.font = ColorandFontTable.usualFont
        ground.addSubview(title)
        ground.backgroundColor = ColorandFontTable.groundPink
        title.snp.makeConstraints { (make) in
            make.centerY.equalTo(ground)
            make.left.equalTo(ground).offset(8)
        }
        return ground
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionIndex
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let key = self.filteredContacts[indexPath.section]
        //let sectionContacts = self.dataSource.searchResult[key as! String]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as! ContactTableViewCell
        cell.selectionStyle = .none
        cell.contact = filteredContacts[sectionIndex[indexPath.section]]?[indexPath.row]
        //cell.delegate = self
        return cell

    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //public func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
    //    return self.filteredContacts as! [String]
    //}

    //Mark: Respond function
    
    func addNewContact()
    {
        let avc = ContactAddTableViewController()
        self.navigationController?.pushViewController(avc, animated: true)
    }
    func backToLast()
    {
        let _ = self.navigationController?.popViewController(animated: true)
    }

   
}

extension ContactTableViewController: UISearchResultsUpdating
{
    public func updateSearchResults(for searchController: UISearchController)
    {
        self.updatefilteredContacts()
    }
    
}

extension ContactTableViewController: UISearchControllerDelegate
{
    public func didDismissSearchController(_ searchController: UISearchController)
    {
        self.updatefilteredContacts()
    }
    public func willDismissSearchController(_ searchController: UISearchController)
    {
        self.updatefilteredContacts()
    }
}

extension ContactTableViewController: UISearchBarDelegate
{
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        self.updatefilteredContacts()
    }
    
    public func searchCancel()
    {
        updatefilteredContacts()
    }
}

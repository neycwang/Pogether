//
//  ContactAddTableViewController.swift
//  Pogether
//
//  Created by KiraMelody on 2017/2/8.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import UIKit

class ContactAddTableViewController: UITableViewController {

    var searchController = UISearchController()
    
    var contacts: [Account] = [] {
        didSet {
            self.updatefilteredContacts()
        }
    }
    
    var sectionIndex: [String] = []
    
    private var filteredContacts: [Account] = []
    
    func initialize()
    {
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
        
        self.title = "新的朋友"
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 20),
                                                                        NSForegroundColorAttributeName: UIColor.white]
        
        self.navigationController?.navigationBar.barTintColor = ColorandFontTable.primaryPink
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
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
        self.searchController.searchBar.placeholder = "用户名/账号"
        self.searchController.searchBar.tintColor = ColorandFontTable.textPink
        self.searchController.searchBar.barTintColor = UIColor.white
        self.searchController.searchBar.backgroundColor = ColorandFontTable.groundPink
        for _ in 0 ... 3 {
            contacts.append(Account(username: "aaa"))
        }
        //NotificationCenter.defaultCenter().removeObserver(self, name: NOTIFICATION_TOKEN_EXPIRED, object: nil)
        //NotificationCenter.defaultCenter().addObserver(self, selector: #selector(tokenExpired), name: NOTIFICATION_TOKEN_EXPIRED, object: nil)
    }
    
    //MARK: - SearchBar
    
    func updatefilteredContacts() {
        self.filteredContacts = self.contacts.filter {
                (!searchController.isActive
                    || ($0.username?.lowercased().contains(searchController.searchBar.text!.lowercased()))!
                    || (searchController.isActive && searchController.searchBar.text! == ""))
        }
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContacts.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let key = self.filteredContacts[indexPath.section]
        //let sectionContacts = self.dataSource.searchResult[key as! String]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as! ContactTableViewCell
        cell.selectionStyle = .none
        cell.contact = filteredContacts[indexPath.row]
        //cell.delegate = self
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let avc = ProfileViewController()
        avc.user = filteredContacts[indexPath.row]
        avc.isStranger = true
        avc.isSetting = false
        self.navigationController?.pushViewController(avc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //Mark: Respond function
    
    func addNewContact()
    {
        
    }
    func backToLast()
    {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension ContactAddTableViewController: UISearchResultsUpdating
{
    public func updateSearchResults(for searchController: UISearchController)
    {
        self.updatefilteredContacts()
    }
    
}

extension ContactAddTableViewController: UISearchControllerDelegate
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

extension ContactAddTableViewController: UISearchBarDelegate
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

//
//  SelectContactTableViewController.swift
//  Pogether
//
//  Created by 王沛晟 on 17/2/21.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import UIKit

protocol SelectContactDelegate: NSObjectProtocol {
    func returnSelectedContacts(returnSelected: [Account])
}

class SelectContactTableViewController: UITableViewController {
    var searchController = UISearchController()
    var returnSelected: [Account] = []
    weak var delegate: SelectContactDelegate?
    
    var contacts: [String : [Account]] = [:] {
        didSet {
            self.updatefilteredContacts()
        }
    }

    var sectionIndex: [String] = []
    
    private var filteredContacts: [String : [Account]] = [:]
    
    func initialize() {
        let backImage = #imageLiteral(resourceName: "ContactList_Back")
        backImage.withRenderingMode(.alwaysOriginal)
        let backButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backToLast))
        self.navigationItem.leftBarButtonItem = backButton
        
        let addImage = UIImage(cgImage: #imageLiteral(resourceName: "EditPhoto_Save").cgImage!, scale: 5, orientation: .up)
        addImage.withRenderingMode(.alwaysOriginal)
        let addButton = UIBarButtonItem(image: addImage, style: .plain, target: self, action: #selector(done))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
      
        self.title = "选择联系人"
        self.navigationController?.navigationBar.isHidden = false
        tableView.estimatedRowHeight = 56
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.delegate = self
        tableView.backgroundColor = ColorandFontTable.groundGray
        tableView.register(SelectContactTableViewCell.self, forCellReuseIdentifier: "SelectContactTableViewCell")
        tableView.dataSource = self
        tableView.sectionIndexColor = ColorandFontTable.primaryPink
        tableView.sectionIndexBackgroundColor = UIColor.clear
        tableView.tableFooterView = UIView(frame: .zero)
        
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
        contacts["T"] = [Account(id: "1", username: "童佳琪"), Account(id: "2", username: "童老师"), Account(id: "3", username: "童学姐"), Account(id: "4", username: "童金牌"), Account(id: "5", username: "太强了")]
        contacts["B"] = [Account(id: "6", username: "别打我")]
        contacts["P"] = [Account(id: "7", username: "Pogether")]
        contacts["D"] = [Account(id: "8", username: "带我飞"), Account(id: "9", username: "大物"), Account(id: "10", username: "打地鼠"), Account(id: "11", username: "假设很长很长很长"), Account(id: "12", username: "假设特别特别特别长")]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.setToolbarHidden(true, animated: false)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    //MARK: - SearchBar
    
    func updatefilteredContacts() {
        filteredContacts = [:]
        for e in contacts {
            for i in e.value {
                if (!searchController.isActive
                    ||
                    (i.username?.lowercased().contains(searchController.searchBar.text!.lowercased()))!
                    ||
                    (searchController.isActive && searchController.searchBar.text! == "")) {
                    if filteredContacts[e.key] == nil {
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
        let ground = UIView()
        ground.frame=CGRect(x: 0.0, y: 0.0, width: tableView.frame.width, height: 22.0)
        ground.backgroundColor = ColorandFontTable.groundPink

        let title = UILabel()
        title.text = sectionIndex[section]
        title.textColor=ColorandFontTable.textPink
        title.font = ColorandFontTable.usualFont
        ground.addSubview(title)
        
        title.snp.makeConstraints({ (make) in
                make.centerY.equalTo(ground.snp.centerY)
                make.left.equalTo(ground.snp.left).offset(8)
            })
        
        return ground
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionIndex
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectContactTableViewCell", for: indexPath) as! SelectContactTableViewCell
        cell.selectionStyle = .none
        cell.contact = filteredContacts[sectionIndex[indexPath.section]]?[indexPath.row]
        for e in returnSelected
        {
            if e.id == (cell.contact?.id)! {
                cell.isChosen = true
                cell.chooseView.image = #imageLiteral(resourceName: "Select_Yes")
            }
        }
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SelectContactTableViewCell
        if cell.isChosen {
            cell.chooseView.image = #imageLiteral(resourceName: "Select_None")
            returnSelected = returnSelected.filter({$0.id != cell.contact?.id})
        }
        else {
            cell.chooseView.image = #imageLiteral(resourceName: "Select_Yes")
            returnSelected.append(cell.contact!)
        }
        cell.isChosen = !cell.isChosen
    }
    
    //Mark: Respond function
    func backToLast() {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    func done() {
        returnSelected.removeAll()
        for allCells in tableView.visibleCells {
            let contactCells = allCells as! SelectContactTableViewCell
            if contactCells.isChosen {
                returnSelected.append(contactCells.contact!)
            }
        }
        self.delegate?.returnSelectedContacts(returnSelected: returnSelected)
        print(returnSelected)
        let _ = self.navigationController?.popViewController(animated: true)
    }
}

extension SelectContactTableViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        self.updatefilteredContacts()
    }
    
}

extension SelectContactTableViewController: UISearchControllerDelegate {
    public func didDismissSearchController(_ searchController: UISearchController) {
        self.updatefilteredContacts()
    }
    public func willDismissSearchController(_ searchController: UISearchController) {
        self.updatefilteredContacts()
    }
}

extension SelectContactTableViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.updatefilteredContacts()
    }
    
    public func searchCancel() {
        updatefilteredContacts()
    }
}

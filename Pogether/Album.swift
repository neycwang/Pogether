//
//  Album.swift
//  Pogether
//
//  Created by KiraMelody on 2017/2/16.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import Foundation

public enum Limit {
    case all
    case myself
    case some
    case somenot
}

class Album {
    
    var id: String? //主键
    var name: String?
    var count: Int?
    var limit: Limit?
    var limitString: String? {
        get {
            if limit == nil {
                return nil
            }
            switch limit! as Limit {
            case .all:
                return "所有人可见"
            case .myself:
                return "仅自己可见"
            case .some:
                return "部分人可见"
            case .somenot:
                return "部分人不可见"
            }
        }
    }
    var avanter: URL?
    
    init()
    {
        
    }
    init(name: String, count: Int, limit: Limit)
    {
        self.name = name
        self.count = count
        self.limit = limit
    }
}

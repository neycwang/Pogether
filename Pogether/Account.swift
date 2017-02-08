//
//  Account.swift
//  Pogether
//
//  Created by KiraMelody on 2017/2/5.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import Foundation

class Account {
    
    enum Sex {
        case male
        case female
    }
    var id: Int? //主键
    var username: String?
    var email: String?
    var signature: String?
    var portrait: URL?
    var poster: URL?
    
    init(id: Int, username: String)
    {
        self.id = id
        self.username = username
    }
}

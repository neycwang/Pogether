//
//  Account.swift
//  Pogether
//
//  Created by KiraMelody on 2017/2/5.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import Foundation

class Account {
    
    var id: String? //主键
    var username: String?
    var email: String?
    var signature: String?
    var avatar: URL?
    
    init()
    {
    }
    init(id: String, username: String)
    {
        self.id = id
        self.username = username
    }
}

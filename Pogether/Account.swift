//
//  Account.swift
//  Pogether
//
//  Created by KiraMelody on 2017/2/5.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import Foundation

class Account {
    
    var username: String?
    var email: String?
    var signature: String?
    var avatar: URL?
    
    init()
    {
    }
    init(username: String)
    {
        self.username = username
    }
}

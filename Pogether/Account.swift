//
//  Account.swift
//  Pogether
//
//  Created by KiraMelody on 2017/2/5.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import Foundation

class Account {
    
    var username: String
    var email: String?
    var signature: String?
    var avatar: URL?
    var background: URL?
    init(username: String)
    {
        self.username = username
    }
    init(username: String, email: String?, signature: String?, avatar: URL?, background: URL?)
    {
        self.username = username
        self.email = email
        self.signature = signature
        self.avatar = avatar
        self.background = background
    }
}

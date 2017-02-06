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
    var sex: Sex?
    var age: Int?
    var signature: String?
    var portrait: URL?
    var poster: URL?
    
    init(username: String)
    {
        self.username = username
    }
}

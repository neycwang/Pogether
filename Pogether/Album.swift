//
//  Album.swift
//  Pogether
//
//  Created by KiraMelody on 2017/2/16.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import Foundation

class Album {
    
    enum Limit {
        case all
        case myself
        case some
        case somenot
    }
    var id: String? //主键
    var name: String?
    var count: Int?
    var limit: Limit?
    var portrait: URL?
}

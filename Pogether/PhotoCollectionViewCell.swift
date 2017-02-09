//
//  PhotoCollectionViewCell.swift
//  Pogether
//
//  Created by KiraMelody on 2017/1/17.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import UIKit
import SnapKit

class PhotoCollectionViewCell: UICollectionViewCell {
    var photoView: UIImageView!
    var indexPath: IndexPath!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        photoView = UIImageView()
        contentView.addSubview(photoView)
        photoView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
    }
    
}


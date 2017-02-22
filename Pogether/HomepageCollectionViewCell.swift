//
//  HomepageCollectionViewCell.swift
//  Pogether
//
//  Created by KiraMelody on 2017/2/4.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import UIKit

class HomepageCollectionViewCell: UICollectionViewCell {
    var iconView: UIImageView!
    var descLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        iconView = UIImageView()
        descLabel = UILabel()
        descLabel.textColor = UIColor.white
        contentView.addSubview(iconView)
        contentView.addSubview(descLabel)
        iconView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(14)
            make.left.equalTo(contentView).offset(20)
            make.width.equalTo(contentView.snp.height).multipliedBy(0.4)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.4)
        }
        descLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(iconView)
            make.top.equalTo(iconView.snp.bottom).offset(12)
            make.bottom.equalTo(contentView).offset(-10)
        }
        
    }
    
}

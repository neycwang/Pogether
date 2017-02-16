//
//  CropCollectionViewCell.swift
//  Pogether
//
//  Created by KiraMelody on 2017/2/15.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import UIKit

class CropCollectionViewCell: UICollectionViewCell {
    var iconView: UIView!
    var titleLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        iconView = UIView()
        iconView.backgroundColor = UIColor.clear
        iconView.layer.borderColor = UIColor.white.cgColor
        iconView.layer.borderWidth = 2
        titleLabel = UILabel()
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        contentView.addSubview(iconView)
        contentView.addSubview(titleLabel)
        iconView.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView).offset(-10)
            make.centerX.equalTo(contentView)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(iconView)
            make.bottom.equalTo(contentView).offset(-10)
        }
        
    }
}

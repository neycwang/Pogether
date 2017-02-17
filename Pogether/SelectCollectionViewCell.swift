//
//  SelectCollectionViewCell.swift
//  Pogether
//
//  Created by KiraMelody on 2017/2/17.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import UIKit

class SelectCollectionViewCell: UICollectionViewCell {
    var photoView: UIImageView!
    var selectView: UIImageView!
    var indexPath: IndexPath!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        photoView = UIImageView()
        selectView = UIImageView()
        contentView.addSubview(photoView)
        contentView.addSubview(selectView)
        photoView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
        if isSelected {
            selectView.image = #imageLiteral(resourceName: "Select_Yes")
        } else {
            selectView.image = #imageLiteral(resourceName: "Select_None")
        }
        selectView.snp.makeConstraints { (make) in
            make.right.equalTo(contentView).offset(-5)
            make.bottom.equalTo(contentView).offset(-5)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
    }
    override func select(_ sender: Any?) {
        
    }
}

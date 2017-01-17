//
//  AlbumTableViewCell.swift
//  Pogether
//
//  Created by KiraMelody on 2017/1/17.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import UIKit
import SnapKit

class AlbumTableViewCell: UITableViewCell {

    var preImageView: UIImageView!
    var descLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        preImageView = UIImageView()
        descLabel = UILabel()
        descLabel.numberOfLines = 0
        descLabel.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(preImageView)
        contentView.addSubview(descLabel)
        preImageView.image = #imageLiteral(resourceName: "default")
        preImageView.contentMode = .scaleToFill
        preImageView.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(30)
            make.height.equalTo(48)
            make.width.equalTo(48)
        }
        descLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(preImageView.snp.right).offset(30)
            make.right.lessThanOrEqualTo(contentView).offset(-50)
            make.top.equalTo(contentView)
            make.bottom.equalTo(contentView)
            make.height.greaterThanOrEqualTo(80)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  ContactTableViewCell.swift
//  Pogether
//
//  Created by KiraMelody on 2017/2/5.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    var portraitView: UIImageView!
    var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        portraitView = UIImageView()
        portraitView.image = #imageLiteral(resourceName: "default")
        portraitView.layer.masksToBounds = true
        portraitView.layer.cornerRadius = portraitView.frame.size.height / 2
        usernameLabel = UILabel()
        usernameLabel.text = "哈哈哈哈"
        usernameLabel.font = UIFont.systemFont(ofSize: 17)
        contentView.addSubview(portraitView)
        contentView.addSubview(usernameLabel)
        portraitView.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(10)
            make.centerY.equalTo(contentView)
            make.height.equalTo(36)
            make.width.equalTo(36)
        }
        usernameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(portraitView.snp.right).offset(10)
            make.centerY.equalTo(contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

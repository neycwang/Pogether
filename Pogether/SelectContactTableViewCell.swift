//
//  SelectContactTableViewCell.swift
//  Pogether
//
//  Created by 王沛晟 on 17/2/21.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import UIKit

class SelectContactTableViewCell: UITableViewCell {
    var portraitView: UIImageView!
    var chooseView: UIImageView!
    var usernameLabel: UILabel!
    var isChosen: Bool = false

    var contact: Account? {
        didSet {
            portraitView.image = #imageLiteral(resourceName: "icon1")
            chooseView.image = #imageLiteral(resourceName: "Select_None")
            usernameLabel.text = contact?.username
        }
    }
        
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        portraitView = UIImageView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        portraitView.image = #imageLiteral(resourceName: "default")
        portraitView.layer.masksToBounds = true
        portraitView.layer.cornerRadius = portraitView.frame.size.height / 2
        
        chooseView = UIImageView(frame: CGRect(x: 0, y: 0, width: 27, height: 27))
        
        if isChosen {
            chooseView.image = #imageLiteral(resourceName: "Select_Yes")
        }
        else{
            chooseView.image = #imageLiteral(resourceName: "Select_None")
        }
        
        usernameLabel = UILabel()
        usernameLabel.text = "默认"
        usernameLabel.font = UIFont.systemFont(ofSize: 17)
        
        contentView.addSubview(portraitView)
        contentView.addSubview(chooseView)
        contentView.addSubview(usernameLabel)
        
        portraitView.snp.makeConstraints({(make) in
            make.centerY.equalTo(contentView.snp.centerY)
            make.left.equalTo(contentView.snp.left).offset(11)
        })
        usernameLabel.snp.makeConstraints({(make) in
            make.centerY.equalTo(contentView.snp.centerY)
            make.left.equalTo(portraitView.snp.right).offset(11)
        })
        chooseView.snp.makeConstraints({(make) in
            make.centerY.equalTo(contentView.snp.centerY)
            make.right.equalTo(contentView.snp.right).offset(-15)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

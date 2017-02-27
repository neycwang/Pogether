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
    var albumNameLabel: UILabel!
    var securityLabel: UILabel!
    var countLabel: UILabel!
    var album: Album = Album() {
        didSet {
            if album.avatar != nil {
                
            }
            albumNameLabel.text = album.name
            securityLabel.text = album.limitString
            if album.count != nil {
                countLabel.text = " (\(album.count!.description))"
            }
        }
    }
    var  select = 0 {
        didSet
        {
            let selectTag = UIView()
            selectTag.backgroundColor = ColorandFontTable.primaryPink
            selectTag.layer.cornerRadius = 8
            selectTag.layer.masksToBounds = true
            self.contentView.addSubview(selectTag)
            selectTag.snp.makeConstraints { (make) in
                make.right.equalTo(contentView)
                make.centerY.equalTo(contentView)
                make.height.equalTo(16)
                make.width.equalTo(30)
            }
            let selectLabel = UILabel()
            selectLabel.textColor = UIColor.white
            selectLabel.font = UIFont.systemFont(ofSize: 14)
            selectLabel.text = select.description
            selectTag.addSubview(selectLabel)
            selectLabel.snp.makeConstraints { (make) in
                make.center.equalTo(selectTag)
            }
            if select == 0 {
                selectTag.isHidden = true
            } else {
                selectTag.isHidden = false
            }
        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        preImageView = UIImageView()
        albumNameLabel = UILabel()
        albumNameLabel.font = UIFont.systemFont(ofSize: 20)
        securityLabel = UILabel()
        securityLabel.font = UIFont.systemFont(ofSize: 12)
        securityLabel.textColor = UIColor.gray
        countLabel = UILabel()
        countLabel.font = UIFont.systemFont(ofSize: 20)
        countLabel.textColor = UIColor.gray
        contentView.addSubview(preImageView)
        contentView.addSubview(albumNameLabel)
        contentView.addSubview(securityLabel)
        contentView.addSubview(countLabel)
        preImageView.image = #imageLiteral(resourceName: "default")
        preImageView.contentMode = .scaleToFill
        preImageView.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(5)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        albumNameLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(preImageView.snp.right).offset(15)
            make.right.lessThanOrEqualTo(contentView).offset(-70)
            
            make.top.equalTo(contentView).offset(15)
        }
        securityLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(preImageView.snp.right).offset(15)
            make.right.lessThanOrEqualTo(contentView).offset(-50)
            make.bottom.equalTo(contentView).offset(-10)
        }
        countLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(albumNameLabel.snp.right)
            make.right.lessThanOrEqualTo(contentView).offset(-20)
            make.centerY.equalTo(albumNameLabel)
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

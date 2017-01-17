//
//  PhotoCollectionViewCell.swift
//  Pogether
//
//  Created by KiraMelody on 2017/1/17.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import UIKit
import SnapKit

protocol PhotoCollectionViewCellDelegate: NSObjectProtocol {
    func willAddImage (_ indexPath: IndexPath)
}
class PhotoCollectionViewCell: UICollectionViewCell {
    var photoView: UIImageView!
    var addButton: UIButton!
    weak var delegate: PhotoCollectionViewCellDelegate?
    var indexPath: IndexPath!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        photoView = UIImageView()
        addButton = UIButton(type: UIButtonType.contactAdd)
        contentView.addSubview(photoView)
        contentView.addSubview(addButton)
        photoView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
        addButton.snp.makeConstraints { (make) in
            make.center.equalTo(contentView)
            make.edges.equalTo(contentView).inset(UIEdgeInsetsMake(20, 20, 20, 20))
        }
        addButton.addTarget(self, action: #selector(PhotoCollectionViewCell.addPhoto), for: UIControlEvents.touchDown)
    }
    
    func addPhoto ()
    {
        self.delegate?.willAddImage(indexPath)
    }
    
}


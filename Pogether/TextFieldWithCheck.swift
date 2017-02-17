//
//  TextFieldWithCheck.swift
//  Pogether
//
//  Created by 王沛晟 on 17/2/7.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import UIKit
import SnapKit

protocol CheckDelegate: NSObjectProtocol {
    func validate (index: Int, text: String)
}

class TextFieldWithCheck: UIView {
    var groundView: UIView!
    
    var textField: UITextField!
    
    var groundImageView:UIImageView!
    var iconImageView: UIImageView!
    var correctImageView: UIImageView!
    var checkHidden = true
    
    var index: Int!
    weak var checkdelegate: CheckDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(index: Int){
        super.init(frame: .zero)
        self.index = index
        self.groundView = UIView(frame: .zero)
        self.textField = UITextField()
        self.textField.returnKeyType = .done
        self.textField.delegate = self
        self.groundImageView = UIImageView()
        self.groundImageView.image = #imageLiteral(resourceName: "LoginView_Box")
        self.iconImageView = UIImageView()
        self.iconImageView.contentMode = .scaleAspectFit
        self.correctImageView = UIImageView()
        self.correctImageView.image = #imageLiteral(resourceName: "RegisterView_CorrectIcon")
        self.correctImageView.isHidden = true
        self.groundView.addSubview(textField)
        self.groundView.addSubview(groundImageView)
        self.groundView.addSubview(iconImageView)
        self.groundView.addSubview(correctImageView)
        self.groundImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.groundView)
        }
        self.iconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(groundView).offset(25)
            make.centerY.equalTo(groundView)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        self.textField.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(15)
            make.centerY.equalTo(groundView)
            make.right.equalTo(correctImageView.snp.left).offset(-15)
        }
        self.correctImageView.snp.makeConstraints { (make) in
            make.right.equalTo(groundView).offset(-25)
            make.centerY.equalTo(groundView)
            make.height.equalTo(groundView).dividedBy(3)
        }
    }
    
    
    func setPosition(frame:CGRect){
        self.groundView.frame = frame
    }
    
}

extension TextFieldWithCheck: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if self.textField.text == "" {
            self.checkHidden = true
        } else {
            self.checkdelegate!.validate(index: index, text: self.textField.text!)
        }
        self.correctImageView.isHidden = self.checkHidden
        self.textField.resignFirstResponder()
        return true
    }
}

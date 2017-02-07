//
//  textFieldWithCheck.swift
//  Pogether
//
//  Created by 王沛晟 on 17/2/7.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import UIKit
import SnapKit

class textFieldWithCheck {
    var groundView: UIView!
    
    var textField: UITextField!
    
    var groundImageView:UIImageView!
    var iconImageView: UIImageView!
    var correctImageView: UIImageView!
    
    init(groundImageView:UIImageView!, iconImageView:UIImageView!, correctImageView:UIImageView!, textFieldPlaceHolder:String!, textFieldFont:UIFont!, textFieldDelegate:UITextFieldDelegate, textFieldFrame:CGRect!){
        self.groundView = UIView()
        self.groundImageView = groundImageView
        self.groundView.addSubview(self.groundImageView)
        self.iconImageView = iconImageView
        self.groundView.addSubview(self.iconImageView)
        self.correctImageView = correctImageView
        self.textField = UITextField()
        self.textField.delegate = textFieldDelegate
        self.textField.returnKeyType = .done
        self.textField.placeholder = textFieldPlaceHolder
        self.textField.font = textFieldFont
        self.textField.frame = textFieldFrame
        self.textField.keyboardType = .asciiCapable
        self.groundView.addSubview(self.textField)
    }
    
    func setPosition(frame:CGRect){
        self.groundView.frame = frame
    }

    func check(){
        if isEmpty() {
            self.correctImageView.removeFromSuperview()
        }else{
            self.groundView.addSubview(self.correctImageView)
        }
    }
    
    func isEmpty() -> Bool {
        return textField.text == ""
    }
    
    func correctIconVisible(visible:Bool){
        if visible == true {
            self.groundView.addSubview(self.correctImageView)
        }else{
            self.correctImageView.removeFromSuperview()
        }
    }
}

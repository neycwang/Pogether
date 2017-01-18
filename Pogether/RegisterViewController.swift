//
//  RegisterViewController.swift
//  P
//
//  Created by apple on 2017/1/18.
//  Copyright © 2017年 Wang. All rights reserved.
//

import SnapKit

class RegisterViewController: UIViewController
{
    var usernameLabel: UILabel!
    var usernameField: UITextField!
    var passwordLabel: UILabel!
    var passwordField: UITextField!
    var repeatPasswordLabel: UILabel!
    var repeatPasswordField: UITextField!
    var mobilePhoneLabel: UILabel!
    var mobilePhoneField: UITextField!
    var registerButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        initialize()
        
        view.addSubview(usernameLabel)
        view.addSubview(usernameField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordField)
        view.addSubview(repeatPasswordLabel)
        view.addSubview(repeatPasswordField)
        view.addSubview(mobilePhoneLabel)
        view.addSubview(mobilePhoneField)
        view.addSubview(registerButton)
        
        view.backgroundColor = .white
        
        usernameLabel.snp.makeConstraints{(make) -> Void in
            make.right.equalTo(view.snp.centerX).offset(-10)
            make.centerY.equalTo(view.snp.top).offset(200)
        }
        usernameField.snp.makeConstraints{(make) -> Void in
            make.left.equalTo(view.snp.centerX).offset(10)
            make.centerY.equalTo(usernameLabel)
        }
        passwordLabel.snp.makeConstraints{(make) -> Void in
            make.right.equalTo(view.snp.centerX).offset(-10)
            make.top.equalTo(usernameLabel.snp.bottom).offset(10)
        }
        passwordField.snp.makeConstraints{(make) -> Void in
            make.left.equalTo(view.snp.centerX).offset(10)
            make.top.equalTo(usernameField.snp.bottom).offset(10)
        }
        repeatPasswordLabel.snp.makeConstraints{(make) -> Void in
            make.right.equalTo(view.snp.centerX).offset(-10)
            make.top.equalTo(passwordLabel.snp.bottom).offset(10)
        }
        repeatPasswordField.snp.makeConstraints{(make) -> Void in
            make.left.equalTo(view.snp.centerX).offset(10)
            make.top.equalTo(passwordField.snp.bottom).offset(10)
        }
        mobilePhoneLabel.snp.makeConstraints{(make) -> Void in
            make.right.equalTo(view.snp.centerX).offset(-10)
            make.top.equalTo(repeatPasswordLabel.snp.bottom).offset(10)
        }
        mobilePhoneField.snp.makeConstraints{(make) -> Void in
            make.left.equalTo(view.snp.centerX).offset(10)
            make.top.equalTo(repeatPasswordField.snp.bottom).offset(10)
        }
        registerButton.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(mobilePhoneField.snp.bottom).offset(10)
            make.centerX.equalTo(view)
        }
    }

    func initialize()
    {
        let font = UIFont.systemFont(ofSize: 24)
        usernameLabel = UILabel()
        usernameLabel.text = "用户名"
        usernameLabel.font = font
        usernameLabel.textAlignment = .right
        
        usernameField = UITextField()
        usernameField.placeholder = "请输入用户名"
        usernameField.font = font
        usernameField.returnKeyType = .done
        usernameField.delegate = self
        
        passwordLabel = UILabel()
        passwordLabel.text = "请输入密码"
        passwordLabel.font = font
        passwordLabel.textAlignment = .right
        
        passwordField = UITextField()
        passwordField.placeholder = "请输入密码"
        passwordField.font = font
        passwordField.returnKeyType = .done
        passwordField.delegate = self
        
        repeatPasswordLabel = UILabel()
        repeatPasswordLabel.text = "确认密码"
        repeatPasswordLabel.font = font
        repeatPasswordLabel.textAlignment = .right
        
        repeatPasswordField = UITextField()
        repeatPasswordField.placeholder = "请再次输入密码"
        repeatPasswordField.font = font
        repeatPasswordField.returnKeyType = .done
        repeatPasswordField.delegate = self
        
        mobilePhoneLabel = UILabel()
        mobilePhoneLabel.text = "手机号"
        mobilePhoneLabel.font = font
        mobilePhoneLabel.textAlignment = .right
        
        mobilePhoneField = UITextField()
        mobilePhoneField.placeholder = "请输入手机号"
        mobilePhoneField.font = font
        mobilePhoneField.returnKeyType = .done
        mobilePhoneField.delegate = self
        
        registerButton = UIButton(type: .roundedRect)
        registerButton.setTitle("注册", for: .normal)
        registerButton.titleLabel?.font = font
        registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
    }
    
    func register()
    {
        
    }
}

extension RegisterViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
}

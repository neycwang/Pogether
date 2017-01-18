//
//  LoginViewController.swift
//  Pogether
//
//  Created by KiraMelody on 2017/1/16.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {

    var usernameLabel: UILabel!
    var usernameField: UITextField!
    var pwdLabel: UILabel!
    var pwdField: UITextField!
    var loginButton: UIButton!
    var registerLabel: UILabel!
    
    func initialize() {
        usernameLabel = UILabel()
        usernameLabel.font = UIFont.systemFont(ofSize: 24)
        usernameLabel.text = "用户名"
        usernameField = UITextField()
        usernameField.placeholder = "请输入用户名"
        pwdLabel = UILabel()
        pwdLabel.font = UIFont.systemFont(ofSize: 24)
        pwdLabel.text = "密码"
        pwdField = UITextField()
        pwdField.placeholder = "请输入密码"
        loginButton = UIButton(type: .roundedRect)
        loginButton.setTitle("登录", for: UIControlState.normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        loginButton.addTarget(self, action: #selector(LoginViewController.jumpToAlbum), for: UIControlEvents.touchUpInside)
        registerLabel = UILabel()
        registerLabel.font = UIFont.systemFont(ofSize: 16)
        registerLabel.text = "新用户？"
        registerLabel.isUserInteractionEnabled = true
        let touchRegisterRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.jumpToRegister))
        registerLabel.addGestureRecognizer(touchRegisterRecognizer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        self.title = "登录"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(usernameLabel)
        self.view.addSubview(usernameField)
        self.view.addSubview(pwdLabel)
        self.view.addSubview(pwdField)
        self.view.addSubview(loginButton)
        self.view.addSubview(registerLabel)
        let bgColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        self.view.backgroundColor = bgColor
        usernameLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.view).offset(-50)
            make.centerY.equalTo(self.view).offset(-100)
        }
        usernameField.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(usernameLabel)
            make.left.equalTo(usernameLabel.snp.right).offset(20)
            make.right.lessThanOrEqualTo(self.view).offset(-20)
        }
        pwdLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(usernameLabel)
            make.top.equalTo(usernameLabel.snp.bottom).offset(20)
        }
        pwdField.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(pwdLabel)
            make.left.equalTo(usernameField)
            make.right.lessThanOrEqualTo(self.view).offset(-20)
        }
        loginButton.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.view)
            make.top.equalTo(pwdLabel.snp.bottom).offset(50)
        }
        registerLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.view)
            make.top.equalTo(loginButton.snp.bottom).offset(50)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Touch event
    func jumpToAlbum() {
        let avc = AlbumTableViewController()
        self.navigationController?.pushViewController(avc, animated: false)
    }
    func jumpToRegister() {
        let avc = RegisterViewController()
        self.navigationController?.pushViewController(avc, animated: false)
    }

}

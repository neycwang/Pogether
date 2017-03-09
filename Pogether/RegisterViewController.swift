//
//  RegisterViewController.swift
//  Pogether
//
//  Created by 王沛晟 on 17/2/6.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import UIKit
import SnapKit

class RegisterViewController: UIViewController {
    
    var cameraImage: UIImageView!
    var appLabel: UILabel!
    var lineImage: UIImageView!
    
    var emailTextFieldWithCheck: TextFieldWithCheck!
    var usernameTextFieldWithCheck: TextFieldWithCheck!
    var passwordTextFieldWithCheck: TextFieldWithCheck!
    var repasswordTextFieldWithCheck: TextFieldWithCheck!
    
    var registerButton: UIButton!
    var closeButton: UIButton!
    var width, height: CGFloat!
    var textFieldFont: UIFont!
    
    func initialize() {
        
        width = view.frame.width
        height = view.frame.height
        textFieldFont = UIFont.systemFont(ofSize: height * 0.03)
        
        cameraImage = UIImageView()
        cameraImage.image = #imageLiteral(resourceName: "LoginView_Camera")
        cameraImage.contentMode = .scaleAspectFit
        
        appLabel = UILabel()
        appLabel.font = UIFont(name: "Quenda", size: height * 0.06)
        appLabel.text = "Pogether"
        appLabel.textAlignment = .center
        appLabel.textColor = .white
        
        lineImage = UIImageView()
        lineImage.image = #imageLiteral(resourceName: "LoginView_Line")
        
        emailTextFieldWithCheck = TextFieldWithCheck(index: 1)
        emailTextFieldWithCheck.iconImageView.image = #imageLiteral(resourceName: "RegisterView_MailIcon")
        emailTextFieldWithCheck.textField.placeholder = "邮箱"
        emailTextFieldWithCheck.textField.font = UIFont.systemFont(ofSize: 20)
        emailTextFieldWithCheck.textField.keyboardType = .emailAddress
        emailTextFieldWithCheck.checkdelegate = self
        
        usernameTextFieldWithCheck = TextFieldWithCheck(index: 2)
        usernameTextFieldWithCheck.iconImageView.image = #imageLiteral(resourceName: "LoginView_User")
        usernameTextFieldWithCheck.textField.placeholder = "用户名"
        usernameTextFieldWithCheck.textField.font = UIFont.systemFont(ofSize: 20)
        usernameTextFieldWithCheck.textField.keyboardType = .default
        usernameTextFieldWithCheck.checkdelegate = self
        
        passwordTextFieldWithCheck = TextFieldWithCheck(index: 3)
        passwordTextFieldWithCheck.iconImageView.image = #imageLiteral(resourceName: "LoginView_Password")
        passwordTextFieldWithCheck.textField.placeholder = "密码"
        passwordTextFieldWithCheck.textField.font = UIFont.systemFont(ofSize: 20)
        passwordTextFieldWithCheck.textField.isSecureTextEntry = true
        passwordTextFieldWithCheck.textField.keyboardType = .default
        passwordTextFieldWithCheck.checkdelegate = self
        
        repasswordTextFieldWithCheck = TextFieldWithCheck(index: 4)
        repasswordTextFieldWithCheck.iconImageView.image = #imageLiteral(resourceName: "LoginView_Password")
        repasswordTextFieldWithCheck.textField.placeholder = "确认密码"
        repasswordTextFieldWithCheck.textField.font = UIFont.systemFont(ofSize: 20)
        repasswordTextFieldWithCheck.textField.isSecureTextEntry = true
        repasswordTextFieldWithCheck.textField.keyboardType = .default
        repasswordTextFieldWithCheck.checkdelegate = self
        
        registerButton = UIButton(type: .roundedRect)
        registerButton.setTitle("注册", for: .normal)
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: height * 0.039)
        registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        let registerButtonImage = UIImage(cgImage: #imageLiteral(resourceName: "RegisterView_RegisterButton").cgImage!, scale: 2000 / height, orientation: .up)
        registerButton.backgroundColor = UIColor(patternImage: registerButtonImage)
        registerButton.setTitleColor(.white, for: .normal)
        
        closeButton = UIButton(type: .roundedRect)
        closeButton.addTarget(self, action: #selector(backToLast), for: .touchUpInside)
        let closeButtonImage = UIImage(cgImage: #imageLiteral(resourceName: "RegisterView_CloseIcon").cgImage!, scale: 2000 / height, orientation: .up)
        closeButton.backgroundColor = UIColor(patternImage: closeButtonImage)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        
        self.view.addSubview(cameraImage)
        self.view.addSubview(appLabel)
        self.view.addSubview(lineImage)
        self.view.addSubview(registerButton)
        self.view.addSubview(closeButton)
        
        self.view.addSubview(emailTextFieldWithCheck.groundView)
        self.view.addSubview(usernameTextFieldWithCheck.groundView)
        self.view.addSubview(passwordTextFieldWithCheck.groundView)
        self.view.addSubview(repasswordTextFieldWithCheck.groundView)
        
        let bgImage = UIImage(cgImage: #imageLiteral(resourceName: "LoginView_Background").cgImage!, scale: 960 / height, orientation: .up)
        self.view.backgroundColor = UIColor(patternImage: bgImage)
        cameraImage.frame = CGRect(x: width / 2 - height * 0.075, y: height * 0.078, width: height * 0.15, height: height * 0.15)
        appLabel.frame = CGRect(x: width / 2 - height * 0.31125, y: height * 0.2325, width: height * 0.6225, height: height * 0.054)
        lineImage.frame = CGRect(x: width / 2 - height * 0.23625, y: height * 0.3085, width: height * 0.4725, height: height * 0.0045)
        
        emailTextFieldWithCheck.setPosition(frame: CGRect(x: width / 2 - height * 0.24375, y: height * 0.3343, width: height * 0.4875, height: height * 0.09))
        usernameTextFieldWithCheck.setPosition(frame: CGRect(x: width / 2 - height * 0.24375, y: height * 0.4453, width: height * 0.4875, height: height * 0.09))
        passwordTextFieldWithCheck.setPosition(frame: CGRect(x: width / 2 - height * 0.24375, y: height * 0.5563, width: height * 0.4875, height: height * 0.09))
        repasswordTextFieldWithCheck.setPosition(frame: CGRect(x: width / 2 - height * 0.24375, y: height * 0.6673, width: height * 0.4875, height: height * 0.09))
        
        registerButton.frame = CGRect(x: width / 2 - height * 0.24375, y: height * 0.7935, width: height * 0.4875, height: height * 0.084)
        closeButton.frame = CGRect(x: height*0.045 , y: height * 0.045, width: height * 0.028, height: height * 0.028)
        
    }
    
    func makeGroundImageView(groundImage:UIImage!) -> UIImageView {
        let newUIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: height * 0.4875, height: height * 0.09))
        newUIImageView.image = groundImage
        return newUIImageView
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    func register() {
        let url = URL(string: "\(APIurl)/signup")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = "{\n  \"email\": \(emailTextFieldWithCheck.textField.text!),\n  \"username\": \(usernameTextFieldWithCheck.textField.text!),\n  \"password\": \(passwordTextFieldWithCheck.textField.text!)\n}".data(using: .utf8)
        let cookie = HTTPCookie(properties: [
            HTTPCookiePropertyKey.name:"Set-Cookie",
            HTTPCookiePropertyKey.value:"user=fsfsdfsdfsfef",
            HTTPCookiePropertyKey.path:"/",
            HTTPCookiePropertyKey.domain: APIurl])
        let storage = HTTPCookieStorage.shared
        storage.setCookie(cookie!)
        let cookieArray = storage.cookies!
        for cookie in cookieArray
        {
            print("name:\(cookie.name),value:\(cookie.value)")
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = response, let data = data {
                //获取注册response
                let json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: String]
                let username = json["username"]!
                let email = json["email"]!
                let signature = json["signature"]!
                let avatar = json["avatar"]!
                let background = json["background"]!
                print("\(username) has successfully signed up")
                //跳转回登陆界面
                self.backToLast()
            } else {
                print(error!)
            }
        }
        
        task.resume()
    }
    
    func backToLast() {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    func recheck() {
        if passwordTextFieldWithCheck.textField.text != repasswordTextFieldWithCheck.textField.text {
            repasswordTextFieldWithCheck.checkHidden = true
            repasswordTextFieldWithCheck.correctImageView.isHidden = true
        }
    }
}

extension RegisterViewController: CheckDelegate {
    func validate(index: Int, text: String) {
        switch index {
        case 1:
            if text != "" {
                emailTextFieldWithCheck.checkHidden = !validateEmail(email: text)
            }
        case 2:
            if text != "" {
                usernameTextFieldWithCheck.checkHidden = false
            }
        case 3:
            if text != "" {
                passwordTextFieldWithCheck.checkHidden = false
                self.recheck()
            }
        default:
            if text != "" {
                repasswordTextFieldWithCheck.checkHidden = false
                self.recheck()
            }
        }
    }
}

func validateEmail(email: String) -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    let emailTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    return emailTest.evaluate(with: email)
}

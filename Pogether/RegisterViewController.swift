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
    
    var emailTextFieldWithCheck: textFieldWithCheck!
    var usernameTextFieldWithCheck: textFieldWithCheck!
    var passwordTextFieldWithCheck: textFieldWithCheck!
    var repasswordTextFieldWithCheck: textFieldWithCheck!
    
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
        
        let emailIconView = makeIconView(frame: CGRect(x: height * 0.03, y: height * 0.027, width: height * 0.045, height: height * 0.033), iconImage: #imageLiteral(resourceName: "RegisterView_MailIcon"))
        let usernameIconView = makeIconView(frame: CGRect(x: height * 0.03, y: height * 0.018, width: height * 0.0495, height: height * 0.0495), iconImage: #imageLiteral(resourceName: "LoginView_Icon0"))
        let passwordIconView = makeIconView(frame: CGRect(x: height * 0.0345, y: height * 0.0195, width: height * 0.039, height: height * 0.039), iconImage: #imageLiteral(resourceName: "LoginView_Icon1"))
        let repasswordIconView = makeIconView(frame: CGRect(x: height * 0.0345, y: height * 0.0195, width: height * 0.039, height: height * 0.039), iconImage: #imageLiteral(resourceName: "LoginView_Icon1"))
        
        emailTextFieldWithCheck = textFieldWithCheck(groundImageView: makeGroundImageView(groundImage: #imageLiteral(resourceName: "LoginView_Box")), iconImageView: emailIconView, correctImageView: makeCorrectIconView(), textFieldPlaceHolder: "邮箱", textFieldFont: self.textFieldFont, textFieldDelegate: self, textFieldFrame: makeFieldFrame())
        emailTextFieldWithCheck.textField.keyboardType = .emailAddress
        
        usernameTextFieldWithCheck = textFieldWithCheck(groundImageView: makeGroundImageView(groundImage: #imageLiteral(resourceName: "LoginView_Box")), iconImageView: usernameIconView, correctImageView: makeCorrectIconView(), textFieldPlaceHolder: "用户名", textFieldFont: self.textFieldFont, textFieldDelegate: self, textFieldFrame: makeFieldFrame())
        usernameTextFieldWithCheck.textField.keyboardType = .default
        
        passwordTextFieldWithCheck = textFieldWithCheck(groundImageView: makeGroundImageView(groundImage: #imageLiteral(resourceName: "LoginView_Box")), iconImageView: passwordIconView, correctImageView: makeCorrectIconView(), textFieldPlaceHolder: "密码", textFieldFont: self.textFieldFont, textFieldDelegate: self, textFieldFrame: makeFieldFrame())
        passwordTextFieldWithCheck.textField.isSecureTextEntry = true
        
        repasswordTextFieldWithCheck = textFieldWithCheck(groundImageView: makeGroundImageView(groundImage: #imageLiteral(resourceName: "LoginView_Box")), iconImageView: repasswordIconView, correctImageView: makeCorrectIconView() , textFieldPlaceHolder: "确认密码", textFieldFont: self.textFieldFont, textFieldDelegate: self, textFieldFrame: makeFieldFrame())
        repasswordTextFieldWithCheck.textField.isSecureTextEntry = true
        
        registerButton = UIButton(type: .roundedRect)
        registerButton.setTitle("注册", for: .normal)
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: height * 0.039)
        registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        let registerButtonImage = UIImage(cgImage: #imageLiteral(resourceName: "RegisterView_RegisterButton").cgImage!, scale: 2000 / height, orientation: .up)
        registerButton.backgroundColor = UIColor(patternImage: registerButtonImage)
        registerButton.setTitleColor(.white, for: .normal)
        
        closeButton = UIButton(type: .roundedRect)
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
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
    
    func makeGroundImageView(groundImage:UIImage!) -> UIImageView{
        let newUIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: height * 0.4875, height: height * 0.09))
        newUIImageView.image = groundImage
        return newUIImageView
    }
    
    func makeIconView(frame:CGRect, iconImage:UIImage!) -> UIImageView{
        let newUIImageView = UIImageView(frame: frame)
        newUIImageView.image = iconImage
        return newUIImageView
    }
    
    func makeCorrectIconView() -> UIImageView {
        let newUIImageView = makeIconView(frame: CGRect(x: height * 0.42, y: height * 0.027, width: height * 0.033, height: height * 0.0285), iconImage: #imageLiteral(resourceName: "RegisterView_CorrectIcon"))
        return newUIImageView
    }
    
    func makeFieldFrame() -> CGRect{
        let frame = CGRect(x: height * 0.105, y: height * 0.0295, width: height * 0.32, height: height * 0.0315)
        return frame
    }
    
    func register() {
        //after registerButton tapped
    }
    
    func close() {
        let avc = LoginViewController()
        self.navigationController?.pushViewController(avc, animated: false)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        emailTextFieldWithCheck.check()
        usernameTextFieldWithCheck.check()
        passwordTextFieldWithCheck.check()
        if(!passwordTextFieldWithCheck.isEmpty() && !repasswordTextFieldWithCheck.isEmpty() && passwordTextFieldWithCheck.textField.text == repasswordTextFieldWithCheck.textField.text){
            repasswordTextFieldWithCheck.correctIconVisible(visible: true)
        }else{
            repasswordTextFieldWithCheck.correctIconVisible(visible: false)
        }
        return true
    }
    
}

//
//  RegisterViewController.swift
//  Pogether
//
//  Created by WPS on 2017/2/6.
//  Copyright © 2017年 WPS. All rights reserved.
//

import UIKit
import SnapKit

class RegisterViewController: UIViewController {
    
    var cameraImage: UIImageView!
    var appLabel: UILabel!
    var lineImage: UIImageView!
    var emailGroundView: UIView!
    var emailCorrectImage: UIImageView!
    var emailField: UITextField!
    var usernameGroundView: UIView!
    var usernameCorrectImage: UIImageView!
    var usernameField: UITextField!
    var passwordGroundView: UIView!
    var passwordCorrectImage: UIImageView!
    var passwordField: UITextField!
    var repasswordGroundView: UIView!
    var repasswordCorrectImage: UIImageView!
    var repasswordField: UITextField!
    var registerButton: UIButton!
    var closeButton: UIButton!
    var width, height: CGFloat!
    var groundViewWidth, groundViewHeight: CGFloat!
    var fieldx,fieldy,fieldWidth,fieldHeight: CGFloat!
    var correctIconX,correctIconY,correctIconWidth,correctIconHeight: CGFloat!
    
    func initialize() {
        
        width = view.frame.width
        height = view.frame.height
        groundViewWidth = height * 0.4875
        groundViewHeight = height * 0.09
        fieldx = height * 0.105
        fieldy = height * 0.0295
        fieldWidth = height * 0.32
        fieldHeight = height * 0.0315
        correctIconX = height * 0.42
        correctIconY = height * 0.027
        correctIconWidth = height * 0.033
        correctIconHeight = height * 0.0285
        
        
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
        
        emailGroundView = UIView()
        let emailBackgroundImage = makeGroundImageView()
        emailBackgroundImage.image = #imageLiteral(resourceName: "LoginView_Box")
        emailGroundView.addSubview(emailBackgroundImage)
        let emailIconImage = UIImageView(frame: CGRect(x: height * 0.03, y: height * 0.027, width: height * 0.045, height: height * 0.033))
        emailIconImage.image = #imageLiteral(resourceName: "RegisterView_MailIcon")
        emailGroundView.addSubview(emailIconImage)
        emailCorrectImage = makeCorrectIconImageView()
        emailCorrectImage.image = #imageLiteral(resourceName: "RegisterView_CorrectIcon")
        emailField = UITextField()
        emailField.delegate = self
        emailField.returnKeyType = .done
        emailField.placeholder = "邮箱"
        emailField.font = UIFont.systemFont(ofSize: height * 0.03)
        emailGroundView.addSubview(emailField)
        
        usernameGroundView = UIView()
        let usernameBackgroundImage = makeGroundImageView()
        usernameBackgroundImage.image = #imageLiteral(resourceName: "LoginView_Box")
        usernameGroundView.addSubview(usernameBackgroundImage)
        let usernameIconImage = UIImageView(frame: CGRect(x: height * 0.03, y: height * 0.018, width: height * 0.0495, height: height * 0.0495))
        usernameIconImage.image = #imageLiteral(resourceName: "LoginView_Icon0")
        usernameGroundView.addSubview(usernameIconImage)
        usernameCorrectImage = makeCorrectIconImageView()
        usernameCorrectImage.image = #imageLiteral(resourceName: "RegisterView_CorrectIcon")
        usernameField = UITextField()
        usernameField.delegate = self
        usernameField.returnKeyType = .done
        usernameField.placeholder = "用户名"
        usernameField.font = UIFont.systemFont(ofSize: height * 0.03)
        usernameGroundView.addSubview(usernameField)
 
        passwordGroundView = UIView()
        let pswBackgroundImage = makeGroundImageView()
        pswBackgroundImage.image = #imageLiteral(resourceName: "LoginView_Box")
        passwordGroundView.addSubview(pswBackgroundImage)
        let passwordIconImage = UIImageView(frame: CGRect(x: height * 0.0345, y: height * 0.0195, width: height * 0.039, height: height * 0.039))
        passwordIconImage.image = #imageLiteral(resourceName: "LoginView_Icon1")
        passwordGroundView.addSubview(passwordIconImage)
        passwordCorrectImage = makeCorrectIconImageView()
        passwordCorrectImage.image = #imageLiteral(resourceName: "RegisterView_CorrectIcon")
        passwordField = UITextField()
        passwordField.delegate = self
        passwordField.returnKeyType = .done
        passwordField.placeholder = "密码"
        passwordField.font = UIFont.systemFont(ofSize: height * 0.03)
        passwordGroundView.addSubview(passwordField)
        
        repasswordGroundView = UIView()
        let repswBackgroundImage = makeGroundImageView()
        repswBackgroundImage.image = #imageLiteral(resourceName: "LoginView_Box")
        repasswordGroundView.addSubview(repswBackgroundImage)
        let repasswordIconImage = UIImageView(frame: CGRect(x: height * 0.0345, y: height * 0.0195, width: height * 0.039, height: height * 0.039))
        repasswordIconImage.image = #imageLiteral(resourceName: "LoginView_Icon1")
        repasswordGroundView.addSubview(repasswordIconImage)
        repasswordCorrectImage = makeCorrectIconImageView()
        repasswordCorrectImage.image = #imageLiteral(resourceName: "RegisterView_CorrectIcon")
        repasswordField = UITextField()
        repasswordField.delegate = self
        repasswordField.returnKeyType = .done
        repasswordField.placeholder = "确认密码"
        repasswordField.font = UIFont.systemFont(ofSize: height * 0.03)
        repasswordGroundView.addSubview(repasswordField)
        
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
        self.view.addSubview(emailGroundView)
        self.view.addSubview(usernameGroundView)
        self.view.addSubview(passwordGroundView)
        self.view.addSubview(repasswordGroundView)
        self.view.addSubview(registerButton)
        self.view.addSubview(closeButton)
        
        let bgImage = UIImage(cgImage: #imageLiteral(resourceName: "LoginView_Background").cgImage!, scale: 960 / height, orientation: .up)
        self.view.backgroundColor = UIColor(patternImage: bgImage)
        cameraImage.frame = CGRect(x: width / 2 - height * 0.075, y: height * 0.078, width: height * 0.15, height: height * 0.15)
        appLabel.frame = CGRect(x: width / 2 - height * 0.31125, y: height * 0.2325, width: height * 0.6225, height: height * 0.054)
        lineImage.frame = CGRect(x: width / 2 - height * 0.23625, y: height * 0.3085, width: height * 0.4725, height: height * 0.0045)
        emailGroundView.frame = CGRect(x: width / 2 - height * 0.24375, y: height * 0.3343, width: groundViewWidth, height: groundViewHeight)
        emailField.frame = makeFieldFrame()
        usernameGroundView.frame = CGRect(x: width / 2 - height * 0.24375, y: height * 0.4453, width: groundViewWidth, height: groundViewHeight)
        usernameField.frame = makeFieldFrame()
        passwordGroundView.frame = CGRect(x: width / 2 - height * 0.24375, y: height * 0.5563, width: groundViewWidth, height:groundViewHeight)
        passwordField.frame = makeFieldFrame()
        repasswordGroundView.frame = CGRect(x: width / 2 - height * 0.24375, y: height * 0.6673, width: groundViewWidth, height: groundViewHeight)
        repasswordField.frame = makeFieldFrame()
        registerButton.frame = CGRect(x: width / 2 - height * 0.24375, y: height * 0.7935, width: height * 0.4875, height: height * 0.084)
        closeButton.frame = CGRect(x: height*0.045 , y: height * 0.045, width: height * 0.028, height: height * 0.028)
    }

    
    func makeGroundImageView() -> UIImageView{
        let newUIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: groundViewWidth, height: groundViewHeight))
        return newUIImageView
    }
    
    func makeCorrectIconImageView() -> UIImageView{
        let newUIImageView = UIImageView(frame: CGRect(x: correctIconX, y: correctIconY, width: correctIconWidth, height: correctIconHeight))
        return newUIImageView
    }
    
    func makeFieldFrame() -> CGRect{
        let frame = CGRect(x: fieldx, y: fieldy, width: fieldWidth, height: fieldHeight)
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

        if(emailField.text != ""){
            emailGroundView.addSubview(emailCorrectImage)
        }
        else{
            emailCorrectImage.removeFromSuperview()
        }
        
        if(usernameField.text != ""){
            usernameGroundView.addSubview(usernameCorrectImage)
        }
        else{
            usernameCorrectImage.removeFromSuperview()
        }

        if(passwordField.text != ""){
            passwordGroundView.addSubview(passwordCorrectImage)
        }
        else{
            passwordCorrectImage.removeFromSuperview()
        }
        
        if(repasswordField.text != "" && repasswordField.text == passwordField.text){
            repasswordGroundView.addSubview(repasswordCorrectImage)
        }
        else{
            repasswordCorrectImage.removeFromSuperview()
        }
        
        return true
    }
}

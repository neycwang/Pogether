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

    var cameraImage: UIImageView!
    var appLabel: UILabel!
    var lineImage: UIImageView!
    var usernameGroundView: UIView!
    var usernameField: UITextField!
    var passwordGroundView: UIView!
    var passwordField: UITextField!
    var loginButton: UIButton!
    var registerButton: UIButton!
    var width, height: CGFloat!
    
    func initialize() {

        width = view.frame.width
        height = view.frame.height
        
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
        
        usernameGroundView = UIView()
        let tmp0 = UIImageView(frame: CGRect(x: 0, y: 0, width: height * 0.4875, height: height * 0.078))
        tmp0.image = #imageLiteral(resourceName: "LoginView_Box")
        usernameGroundView.addSubview(tmp0)
        let tmp1 = UIImageView(frame: CGRect(x: height * 0.03, y: height * 0.015, width: height * 0.0495, height: height * 0.0495))
        tmp1.image = #imageLiteral(resourceName: "LoginView_User")
        usernameGroundView.addSubview(tmp1)
        
        usernameField = UITextField()
        usernameField.delegate = self
        usernameField.returnKeyType = .done
        usernameField.placeholder = "用户名"
        usernameField.font = UIFont.systemFont(ofSize: height * 0.03)
        usernameGroundView.addSubview(usernameField)
        
        passwordGroundView = UIView()
        let tmp2 = UIImageView(frame: CGRect(x: 0, y: 0, width: height * 0.4875, height: height * 0.078))
        tmp2.image = #imageLiteral(resourceName: "LoginView_Box")
        passwordGroundView.addSubview(tmp2)
        let tmp3 = UIImageView(frame: CGRect(x: height * 0.0345, y: height * 0.0165, width: height * 0.039, height: height * 0.039))
        tmp3.image = #imageLiteral(resourceName: "LoginView_Password")
        passwordGroundView.addSubview(tmp3)
        
        passwordField = UITextField()
        passwordField.delegate = self
        passwordField.returnKeyType = .done
        passwordField.isSecureTextEntry = true
        passwordField.placeholder = "密码"
        passwordField.font = UIFont.systemFont(ofSize: height * 0.03)
        passwordGroundView.addSubview(passwordField)
        
        loginButton = UIButton(type: .roundedRect)
        loginButton.setTitle("登录", for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: height * 0.039)
        loginButton.addTarget(self, action: #selector(LoginViewController.login), for: .touchUpInside)
        let buttonImage = UIImage(cgImage: #imageLiteral(resourceName: "LoginView_Login").cgImage!, scale: 2000 / height, orientation: .up)
        loginButton.backgroundColor = UIColor(patternImage: buttonImage)
        loginButton.setTitleColor(.white, for: .normal)
        
        registerButton = UIButton(type: .roundedRect)
        registerButton.setTitle("注册", for: .normal)
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: height * 0.027)
        registerButton.addTarget(self, action: #selector(LoginViewController.jumpToRegister), for: .touchUpInside)
        registerButton.setTitleColor(ColorandFontTable.textPink, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        
        self.title = "登录"
        
        self.view.addSubview(cameraImage)
        self.view.addSubview(appLabel)
        self.view.addSubview(lineImage)
        self.view.addSubview(usernameGroundView)
        self.view.addSubview(passwordGroundView)
        self.view.addSubview(loginButton)
        self.view.addSubview(registerButton)
        let bgImage = UIImage(cgImage: #imageLiteral(resourceName: "LoginView_Background").cgImage!, scale: 960 / height, orientation: .up)
        self.view.backgroundColor = UIColor(patternImage: bgImage)
        cameraImage.frame = CGRect(x: width / 2 - height * 0.075, y: height * 0.237, width: height * 0.15, height: height * 0.15)
        appLabel.frame = CGRect(x: width / 2 - height * 0.31125, y: height * 0.3915, width: height * 0.6225, height: height * 0.054)
        lineImage.frame = CGRect(x: width / 2 - height * 0.23625, y: height * 0.4875, width: height * 0.4725, height: height * 0.0045)
        usernameGroundView.frame = CGRect(x: width / 2 - height * 0.24375, y: height * 0.5175, width: height * 0.4875, height: height * 0.078)
        usernameField.frame = CGRect(x: height * 0.1, y: height * 0.0255, width: height * 0.40425, height: height * 0.0315)
        passwordGroundView.frame = CGRect(x: width / 2 - height * 0.24375, y: height * 0.597, width: height * 0.4875, height: height * 0.078)
        passwordField.frame = CGRect(x: height * 0.1, y: height * 0.0255, width: height * 0.39975, height: height * 0.0315)
        loginButton.frame = CGRect(x: width / 2 - height * 0.24375, y: height * 0.6975, width: height * 0.4875, height: height * 0.0735)
        registerButton.frame = CGRect(x: width / 2 - height * 0.0285, y: height * 0.795, width: height * 0.057, height: height * 0.0285)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
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
    func login(){
        //懒得等加载
        //self.jumpToHomepage()
        //return
        
        let url = URL(string: "https://\(APIurl)/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\n  \"username\": \(usernameField.text!),\n  \"password\": \(passwordField.text!)\n}".data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = response, let data = data {
                //print(response)
                let json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: String]
                let username = json["username"]!
                let email = json["email"]
                let signature = json["signature"]
                let avatar = json["avatar"]
                let background = json["background"]
                print("\(username) has successfully loged in")
                UserDefaults.standard.set(username, forKey: "USERNAME")
                UserDefaults.standard.set(email, forKey: "EMAIL")
                UserDefaults.standard.set(signature, forKey: "SIGNATURE")
                UserDefaults.standard.set(avatar, forKey: "AVATAR")
                UserDefaults.standard.set(background, forKey: "BACKGROUND")
                self.jumpToHomepage()
                
            } else {
                print(error!)
            }
        }
        task.resume()
    }
    
    func jumpToHomepage() {
        let avc = HomepageCollectionViewController()
        self.navigationController?.pushViewController(avc, animated: false)
    }
    func jumpToRegister() {
        let avc = RegisterViewController()
        self.navigationController?.pushViewController(avc, animated: false)
    }

}

extension LoginViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
}

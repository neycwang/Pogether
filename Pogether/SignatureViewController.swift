//
//  SignatureViewController.swift
//  Pogether
//
//  Created by apple on 2017/2/9.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import SnapKit

class SignatureViewController: UIViewController
{
    var width, height: CGFloat!
    
    var textView: UITextView!
    var countLabel: UILabel!
    
    func initialize()
    {
        view.backgroundColor = ColorandFontTable.signatureViewBackground
        
        let vcs = navigationController!.viewControllers
        let vc = vcs[vcs.count - 2] as! ProfileViewController
        
        textView = UITextView()
        textView.delegate = self
        textView.font = .systemFont(ofSize: 24)
        textView.textAlignment = .justified
        if vc.user.signature != nil
        {
            textView.text = vc.user.signature
        }
        else
        {
            textView.text = ""
        }
        
        countLabel = UILabel()
        let len = (textView.text as NSString).length
        countLabel.text = "\(30 - len)"
        countLabel.font = .systemFont(ofSize: 20)
        countLabel.textColor = ColorandFontTable.labelPink
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationController!.navigationBar.isHidden = false
        title = "个性签名"
        navigationController!.navigationBar.barTintColor = ColorandFontTable.tintPink
        navigationController!.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 20), NSForegroundColorAttributeName: UIColor.white]
        navigationController!.navigationBar.items![0].title = "个人信息"
        let doneButton = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(done))
        doneButton.tintColor = .white
        navigationItem.rightBarButtonItem = doneButton
        
        width = view.frame.width
        height = view.frame.height
        
        initialize()
        
        view.addSubview(textView)
        view.addSubview(countLabel)
        
        textView.snp.makeConstraints{(make) in
            make.top.equalTo(view.snp.top).offset(100)
            make.left.equalTo(view.snp.left)
            make.width.equalTo(width)
            make.height.equalTo(115)
        }
        
        countLabel.snp.makeConstraints{(make) in
            make.right.equalTo(textView.snp.right)
            make.bottom.equalTo(textView.snp.bottom)
            make.height.equalTo(30)
            make.width.equalTo(40)
        }
    }
    
    func done()
    {
        let vcs = navigationController!.viewControllers
        let vc = vcs[vcs.count - 2] as! ProfileViewController
        vc.user.signature = textView.text
        navigationController!.popViewController(animated: true)
    }
}
extension SignatureViewController: UITextViewDelegate
{
    func textViewDidChange(_ textView: UITextView)
    {
        var x = textView.text as NSString
        if x.length > 30
        {
            x = x.substring(to: 30) as NSString
            textView.text = x as String
        }
        countLabel.text = "\(30 - x.length)"
    }
}

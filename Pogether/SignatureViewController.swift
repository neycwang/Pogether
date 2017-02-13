//
//  SignatureViewController.swift
//  Pogether
//
//  Created by apple on 2017/2/9.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import SnapKit

protocol SignatureDelegate: NSObjectProtocol {
    func SignatureDidChange(signature: String)
}

class SignatureViewController: UIViewController
{
    var textView: UITextView!
    var countLabel: UILabel!
    var signature: String!
    weak var delegate: SignatureDelegate?
    
    let textLimitation = 50
    
    func initialize()
    {
        view.backgroundColor = ColorandFontTable.signatureViewBackground
        
        textView = UITextView()
        textView.delegate = self
        textView.font = .systemFont(ofSize: 24)
        textView.textAlignment = .left
        if signature != nil
        {
            textView.text = signature
        }
        else
        {
            textView.text = ""
        }
        
        countLabel = UILabel()
        let len = (textView.text as NSString).length
        countLabel.text = "\(textLimitation - len)"
        countLabel.font = .systemFont(ofSize: 20)
        countLabel.textColor = ColorandFontTable.labelPink
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationController!.navigationBar.isHidden = false
        title = "个性签名"
        self.title = "个人信息"
        let doneButton = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(done))
        navigationItem.rightBarButtonItem = doneButton
        
        initialize()
        
        view.addSubview(textView)
        view.addSubview(countLabel)
        
        textView.snp.makeConstraints{(make) in
            make.top.equalTo(view).offset(100)
            make.left.equalTo(view)
            make.width.equalTo(view)
            make.height.equalTo(115)
        }
        
        countLabel.snp.makeConstraints{(make) in
            make.right.equalTo(textView).offset(-20)
            make.bottom.equalTo(textView).offset(-10)
        }
    }
    
    func done()
    {
        self.delegate?.SignatureDidChange(signature: signature)
        self.navigationController!.popViewController(animated: true)
    }
}
extension SignatureViewController: UITextViewDelegate
{
    func textViewDidChange(_ textView: UITextView)
    {
        var x = textView.text as NSString
        if x.length > textLimitation
        {
            x = x.substring(to: textLimitation) as NSString
            textView.text = x as String
        }
        countLabel.text = "\(textLimitation - x.length)"
        self.signature = x as String
    }
}

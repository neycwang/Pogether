//
//  ProfileViewController.swift
//  Pogether
//
//  Created by apple on 2017/1/17.
//  Copyright © 2017年 Wang. All rights reserved.
//

import SnapKit

class ProfileViewController: UIViewController, UINavigationControllerDelegate
{
    var width, height: CGFloat!
    
    var scrollView: UIScrollView!
    var wallpaperView: UIImageView!
    var iconView: UIImageView!
    
    var usernameLabel: UILabel!
    var idLabel: UILabel!
    
    var signatureView: UIView!
    var signatureLabel: UILabel!
    var signatureContentLabel: UILabel?
    
    var line0: UIImageView!
    
    var albumView: UIView!
    var albumLabel: UILabel!
    var albumFrame0: UIImageView!
    var albumFrame1: UIImageView!
    var albumFrame2: UIImageView!
    var albumArrow: UIImageView!
    
    var line1: UIImageView!
    
    var settingsButton: UIButton!
    var backButton: UIButton!
    
    public var user: Account!
    
    var isIcon = false
    var isSetting = false
    var isStranger = false
    
    func initialize() {
        width = view.frame.width
        height = view.frame.height
        
        wallpaperView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height * 0.3555))
        wallpaperView.contentMode = .scaleAspectFill
        wallpaperView.clipsToBounds = true
        if user.avatar != nil
        {
            wallpaperView.image = imageFromURL(url: user.avatar!)
        }
        else
        {
            wallpaperView.image = #imageLiteral(resourceName: "Profile_Background")
        }
        
        scrollView = UIScrollView(frame: view.frame)
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 1
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize(width: width, height: height)
        
        iconView = UIImageView(frame: CGRect(x: width / 2 - height * 0.08625, y: height * 0.26925, width: height * 0.1725, height: height * 0.1725))
        iconView.contentMode = .scaleAspectFill
        if user.portrait != nil
        {
            iconView.image = imageFromURL(url: user.portrait!)
        }
        else
        {
            iconView.image = #imageLiteral(resourceName: "icon")
        }
        let imageLayer = iconView.layer
        imageLayer.masksToBounds = true
        imageLayer.cornerRadius = iconView.frame.size.height / 2
        
        usernameLabel = UILabel()
        usernameLabel.text = user.username
        usernameLabel.textAlignment = .center
        usernameLabel.font = .systemFont(ofSize: height * 0.036)
        
        idLabel = UILabel()
        idLabel.text = "账号：\(user.id!)"
        idLabel.textAlignment = .center
        idLabel.font = .systemFont(ofSize: height * 0.024)
        idLabel.textColor = ColorandFontTable.textGray0
        
        signatureView = UIView()
        signatureView.backgroundColor = ColorandFontTable.transparent
        let longPress0 = UILongPressGestureRecognizer(target: self, action: #selector(holdingSignature(sender:)))
        longPress0.minimumPressDuration = 0.1
        signatureView.addGestureRecognizer(longPress0)
        signatureLabel = UILabel()
        signatureLabel.text = "签名"
        signatureLabel.textColor = ColorandFontTable.textGray1
        signatureLabel.textAlignment = .center
        signatureLabel.font = .systemFont(ofSize: 20)
        signatureContentLabel = UILabel()
        if user.signature != nil
        {
            signatureContentLabel!.text = user.signature!
        }
        else
        {
            signatureContentLabel!.text = ""
        }
        signatureContentLabel!.font = .systemFont(ofSize: 18)
        signatureContentLabel!.lineBreakMode = .byTruncatingTail
        line0 = UIImageView()
        line0.image = #imageLiteral(resourceName: "ProfileView_Line")
        
        albumView = UIView()
        albumView.backgroundColor = ColorandFontTable.transparent
        let longPress1 = UILongPressGestureRecognizer(target: self, action: #selector(holdingAlbum(sender:)))
        longPress1.minimumPressDuration = 0.1
        albumView.addGestureRecognizer(longPress1)
        albumLabel = UILabel()
        albumLabel.text = "相册"
        albumLabel.textColor = ColorandFontTable.textGray1
        albumLabel.textAlignment =  .center
        albumLabel.font = .systemFont(ofSize: 20)
        albumFrame0 = UIImageView()
        albumFrame0.backgroundColor = ColorandFontTable.fillGray
        albumFrame0.layer.borderWidth = 1
        albumFrame0.layer.borderColor = ColorandFontTable.borderGray.cgColor
        albumFrame0.contentMode = .scaleAspectFit
        albumFrame1 = UIImageView()
        albumFrame1.backgroundColor = ColorandFontTable.fillGray
        albumFrame1.layer.borderWidth = 1
        albumFrame1.layer.borderColor = ColorandFontTable.borderGray.cgColor
        albumFrame1.contentMode = .scaleAspectFit
        albumFrame2 = UIImageView()
        albumFrame2.backgroundColor = ColorandFontTable.fillGray
        albumFrame2.layer.borderWidth = 1
        albumFrame2.layer.borderColor = ColorandFontTable.borderGray.cgColor
        albumFrame2.contentMode = .scaleAspectFit
        albumArrow = UIImageView()
        albumArrow.image = #imageLiteral(resourceName: "ProfileView_Arrow")
        albumArrow.contentMode = .scaleAspectFit
        
        line1 = UIImageView()
        line1.image = #imageLiteral(resourceName: "ProfileView_Line")
        
        settingsButton = UIButton(type: .roundedRect)
        settingsButton.layer.cornerRadius = 5
        if isSetting {
            settingsButton.setTitle("退出账号", for: .normal)
            settingsButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        } else if isStranger {
            settingsButton.setTitle("加为好友", for: .normal)
            settingsButton.addTarget(self, action: #selector(settings), for: .touchUpInside)
        } else {
            settingsButton.setTitle("设置权限", for: .normal)
            settingsButton.addTarget(self, action: #selector(addFriend), for: .touchUpInside)
        }
        
        settingsButton.setTitleColor(.white, for: .normal)
        settingsButton.backgroundColor = ColorandFontTable.tintPink
        settingsButton.titleLabel?.font = .systemFont(ofSize: height * 0.03)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(sender:)))
        view.addGestureRecognizer(tap)
        
        
        backButton = UIButton(frame: CGRect(x: 10, y: 20, width: 20, height: 20))
        backButton.setImage(#imageLiteral(resourceName: "ProfileView_Back"), for: .normal)
        backButton.isUserInteractionEnabled = true
        backButton.addTarget(self, action: #selector(backToLast), for: .touchUpInside)
        
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationController!.navigationBar.isHidden = true
        
        user = Account(id: "14307130105", username: "祝TB生日快乐")
        user.signature = "Pain is temporary, but GPA is"
        
        initialize()
        
        scrollView.addSubview(usernameLabel)
        scrollView.addSubview(idLabel)
        scrollView.addSubview(signatureView)
        scrollView.addSubview(signatureLabel)
        scrollView.addSubview(signatureContentLabel!)
        scrollView.addSubview(line0)
        scrollView.addSubview(albumView)
        scrollView.addSubview(albumLabel)
        scrollView.addSubview(albumFrame0)
        scrollView.addSubview(albumFrame1)
        scrollView.addSubview(albumFrame2)
        scrollView.addSubview(albumArrow)
        scrollView.addSubview(line1)
        scrollView.addSubview(settingsButton)

        view.addSubview(scrollView)
        view.addSubview(wallpaperView)
        view.addSubview(iconView)
        view.addSubview(backButton)
        usernameLabel.snp.makeConstraints{(make) in
            make.centerX.equalTo(scrollView)
            make.top.equalTo(scrollView).offset(height * 0.456)
            make.height.equalTo(height * 0.036)
        }
        
        idLabel.snp.makeConstraints{(make) in
            make.centerX.equalTo(scrollView.snp.centerX)
            make.top.equalTo(scrollView).offset(height * 0.504)
            make.height.equalTo(height * 0.024)
        }
        
        signatureView.snp.makeConstraints{(make) in
            make.left.equalTo(scrollView)
            make.width.equalTo(width)
            make.top.equalTo(scrollView).offset(height * 0.564)
            make.height.equalTo(height * 0.057)
        }
        
        signatureLabel.snp.makeConstraints{(make) in
            make.left.equalTo(scrollView)
            make.width.equalTo(width * 0.224)
            make.top.equalTo(signatureView)
            make.bottom.equalTo(signatureView)
        }
        
        signatureContentLabel!.snp.makeConstraints{(make) in
            make.left.equalTo(scrollView).offset(width * 0.23)
            make.width.equalTo(width * 0.77)
            make.top.equalTo(signatureView)
            make.bottom.equalTo(signatureView)
        }
        
        line0.snp.makeConstraints{(make) in
            make.top.equalTo(scrollView).offset(height * 0.6315)
            make.left.equalTo(signatureLabel.snp.right)
            make.width.equalTo(width * 0.776)
            make.height.equalTo(2)
        }
        
        albumView.snp.makeConstraints{(make) in
            make.left.equalTo(scrollView.snp.left)
            make.width.equalTo(width)
            make.top.equalTo(scrollView.snp.top).offset(height * 0.642)
            make.height.equalTo(height * 0.147)
        }
        
        albumLabel.snp.makeConstraints{(make) in
            make.left.equalTo(scrollView.snp.left)
            make.width.equalTo(width * 0.224)
            make.top.equalTo(albumView.snp.top)
            make.bottom.equalTo(albumView.snp.bottom)
        }
        
        albumFrame0.snp.makeConstraints{(make) in
            make.top.equalTo(scrollView.snp.top).offset(height * 0.6585)
            make.left.equalTo(signatureContentLabel!.snp.left)
            make.width.equalTo(width / 5)
            make.height.equalTo(height * 0.1125)
        }
        
        albumFrame1.snp.makeConstraints{(make) in
            make.top.equalTo(albumFrame0.snp.top)
            make.left.equalTo(albumFrame0.snp.right).offset(width * 0.027)
            make.height.equalTo(albumFrame0.snp.height)
            make.width.equalTo(albumFrame0.snp.width)
        }
        
        albumFrame2.snp.makeConstraints{(make) in
            make.top.equalTo(albumFrame0.snp.top)
            make.left.equalTo(albumFrame1.snp.right).offset(width * 0.027)
            make.height.equalTo(albumFrame0.snp.height)
            make.width.equalTo(albumFrame0.snp.width)
        }
        
        albumArrow.snp.makeConstraints{(make) in
            //make.right.equalTo(scrollView.snp.right).offset(-width * 0.032)
            make.left.equalTo(scrollView.snp.left).offset(width * 0.92)
            make.top.equalTo(scrollView.snp.top).offset(height * 0.7035)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        line1.snp.makeConstraints{(make) in
            make.top.equalTo(scrollView.snp.top).offset(height * 0.798)
            make.left.equalTo(signatureLabel.snp.right)
            make.width.equalTo(width * 0.776)
            make.height.equalTo(2)
        }
        
        settingsButton.snp.makeConstraints{(make) in
            make.top.equalTo(scrollView.snp.top).offset(height * 0.822)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.width.equalTo(width * 0.9)
            make.height.equalTo(height * 0.069)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController!.navigationBar.isHidden = true
        if signatureContentLabel != nil && user.signature != nil
        {
            signatureContentLabel!.text = user.signature
        }
    }
    
    func imageFromURL(url: URL) -> UIImage?
    {
        let data = NSData(contentsOf: url)
        if data == nil
        {
            return nil
        }
        return UIImage(data: data! as Data)
    }
    
    func tapped(sender: UITapGestureRecognizer)
    {
        let loc = sender.location(in: view)
        if iconView.frame.contains(loc)
        {
            changeIcon()
            return
        }
        if wallpaperView.frame.contains(loc)
        {
            changeWallpaper()
            return
        }
        if signatureView.frame.contains(loc)
        {
            tappedSignature()
        }
        if albumView.frame.contains(loc)
        {
            tappedAlbum()
        }
    }
    
    func changeWallpaper()
    {
        let picker = UIImagePickerController()
        picker.delegate = self
        isIcon = false
        let alert = UIAlertController(title: "更换封面", message: "", preferredStyle: .actionSheet)
        let action0 = UIAlertAction(title: "从相册选择", style: .default){(handler) in
            self.navigationController!.present(picker, animated: true, completion: nil)
        }
        let action1 = UIAlertAction(title: "拍一张", style: .default){(handler) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
            {
                picker.sourceType = .camera
                self.navigationController!.present(picker, animated: true, completion: nil)
            }
            else
            {
                NSLog("不支持相机")
            }
        }
        let action2 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(action0)
        alert.addAction(action1)
        alert.addAction(action2)
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func changeIcon()
    {
        let picker = UIImagePickerController()
        picker.delegate = self
        isIcon = true
        let alert = UIAlertController(title: "更换头像", message: "", preferredStyle: .actionSheet)
        let action0 = UIAlertAction(title: "从默认头像选择", style: .default){(handler) in
            let rand = arc4random() % 31
            self.iconView.image = UIImage(imageLiteralResourceName: "whatwhat_pc_icons\(rand)")
        }
        let action1 = UIAlertAction(title: "从手机相册选择", style: .default){(handler) in
            self.navigationController!.present(picker, animated: true, completion: nil)
        }
        let action2 = UIAlertAction(title: "拍一张", style: .default){(handler) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
            {
                picker.sourceType = .camera
                self.navigationController!.present(picker, animated: true, completion: nil)
            }
            else
            {
                NSLog("不支持相机")
            }
        }
        let action3 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(action0)
        alert.addAction(action1)
        alert.addAction(action2)
        alert.addAction(action3)
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func holdingSignature(sender: UILongPressGestureRecognizer)
    {
        if sender.state == .began
        {
            signatureView.backgroundColor = ColorandFontTable.groundGray
        }
        else
        {
            signatureView.backgroundColor = ColorandFontTable.transparent
        }
    }
    
    func holdingAlbum(sender: UILongPressGestureRecognizer)
    {
        if sender.state == .began
        {
            albumView.backgroundColor = ColorandFontTable.groundGray
        }
        else
        {
            albumView.backgroundColor = ColorandFontTable.transparent
        }
    }
    func backToLast()
    {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    func tappedSignature()
    {
        let svc = SignatureViewController()
        svc.delegate = self
        svc.signature = self.user.signature
        navigationController?.pushViewController(svc, animated: true)
    }
    
    func tappedAlbum()
    {
        NSLog("Album")
    }
    
    func settings()
    {
        NSLog("Settings")
    }
    func logout()
    {
        NSLog("Logout")
    }
    func addFriend()
    {
        NSLog("addFriend")
    }
}

//MARK: scrollcontrol

extension ProfileViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        if scrollView.contentOffset.y < 0
        {
            let ratio =  -scrollView.contentOffset.y / 0.3555 / height
            wallpaperView.frame = CGRect(x: -ratio * width / 2, y: 0, width: width * (1 + ratio), height: height * 0.3555 * (1 + ratio))
        }
        else
        {
            let offset = scrollView.contentOffset.y
            wallpaperView.frame = CGRect(x: 0, y: -offset, width: width, height: height * 0.3555)
        }
        iconView.frame = CGRect(x: width / 2 - height * 0.08625, y: height * 0.26925 - scrollView.contentOffset.y, width: height * 0.1725, height: height * 0.1725)
    }
}

//MARK: ImagePicker

extension ProfileViewController: UIImagePickerControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let selectImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        if isIcon
        {
            iconView.image = selectImage
        }
        else
        {
            wallpaperView.image = selectImage
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
    }
}

//MARK: Change Signature
extension ProfileViewController: SignatureDelegate
{
    func SignatureDidChange(signature: String) {
        signatureContentLabel!.text = signature
        user.signature = signature
    }
}

//
//  MattingViewController.swift
//  Pogether
//
//  Created by KiraMelody on 2017/2/15.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import UIKit

class MattingViewController: ScrollImageViewController {

    var groundView: UIView!
    var slider: UISlider!
    var sliderLabel : UILabel!
    
    func initialize()
    {
        let a0 = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Feather"), style: .plain, target: self, action: #selector(featherSlider))
        let a1 = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Weight"), style: .plain, target: self, action: #selector(weightSlider))
        let a2 = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Contrast"), style: .plain, target: self, action: #selector(contrastSlider))
        let cancel = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Cancel"), style: .plain, target: self, action: #selector(backToLast))
        let save = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Save"), style: .plain, target: self, action: #selector(backToLast))
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let barArray = [cancel, space, a0, space, a1, space, a2, space, save]
        self.toolbarItems = barArray
        
        groundView = UIView()
        groundView.backgroundColor = ColorandFontTable.primaryPink
        
        slider = UISlider()
        slider.minimumTrackTintColor = ColorandFontTable.purple
        slider.maximumTrackTintColor = ColorandFontTable.fillGray
        slider.thumbTintColor = UIColor.white
        
        sliderLabel = UILabel()
        sliderLabel.font = UIFont.systemFont(ofSize: 14)
        sliderLabel.textColor = UIColor.white
        
        super.setScrollView()
        scrollImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(20)
            make.bottom.equalTo(self.view).offset(-50)
            make.left.equalTo(self.view).offset(10)
            make.right.equalTo(self.view).offset(-10)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        self.view.addSubview(groundView)
        self.view.addSubview(slider)
        self.view.addSubview(sliderLabel)
        groundView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view).offset(-45)
            make.height.equalTo(60)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
        }
        slider.snp.makeConstraints { (make) in
            make.centerX.equalTo(groundView)
            make.top.equalTo(groundView).offset(10)
            make.height.equalTo(20)
            make.width.equalTo(280)
        }
        sliderLabel.snp.makeConstraints { (make) in
            make.top.equalTo(slider.snp.bottom).offset(8)
            make.centerX.equalTo(slider)
        }
        self.view.backgroundColor = ColorandFontTable.groundGray
        self.groundView.isHidden = true
        self.slider.isHidden = true
        self.sliderLabel.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setToolbarHidden(false, animated: false)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    func featherSlider()
    {
        self.groundView.isHidden = false
        self.slider.isHidden = false
        self.sliderLabel.isHidden = false
        sliderLabel.text = "羽化"
        slider.value = 50
        slider.minimumValue = 0
        slider.maximumValue = 100
    }
    func weightSlider()
    {
        self.groundView.isHidden = false
        self.slider.isHidden = false
        self.sliderLabel.isHidden = false
        sliderLabel.text = "笔粗"
        slider.minimumValue = 0
        slider.maximumValue = 10
    }
    func contrastSlider()
    {
        self.groundView.isHidden = false
        self.slider.isHidden = false
        self.sliderLabel.isHidden = false
        sliderLabel.text = "对比度"
        slider.minimumValue = 0
        slider.maximumValue = 1
    }
    func backToLast()
    {
        let _ = self.navigationController?.popViewController(animated: true)
    }
}

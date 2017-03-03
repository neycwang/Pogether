//
//  EraseViewController.swift
//  Pogether
//
//  Created by KiraMelody on 2017/3/3.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import UIKit
import MGDrawingSlate

class EraseViewController: UIViewController {
    var photoImageView: UIImageView!
    var photo: UIImage!
    var groundView: UIView!
    var slider: UISlider!
    var sliderLabel : UILabel!
    var drawingSlate: MGDrawingSlate!
    var weight: Int = 5
    func initialize()
    {
        let a0 = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Weight"), style: .plain, target: self, action: #selector(weightSlider))
        let cancel = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Cancel"), style: .plain, target: self, action: #selector(backToLast))
        let save = UIBarButtonItem(image: #imageLiteral(resourceName: "EditPhoto_Save"), style: .plain, target: self, action: #selector(backToLast))
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let barArray = [cancel, space, a0, space, save]
        self.toolbarItems = barArray
        
        groundView = UIView()
        groundView.backgroundColor = ColorandFontTable.primaryPink
        
        slider = UISlider()
        slider.minimumTrackTintColor = ColorandFontTable.purple
        slider.maximumTrackTintColor = ColorandFontTable.fillGray
        slider.thumbTintColor = UIColor.white
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        
        sliderLabel = UILabel()
        sliderLabel.font = UIFont.systemFont(ofSize: 14)
        sliderLabel.textColor = UIColor.white

        photoImageView = UIImageView()//(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.width - 20, height: self.view.frame.height - 190)))
        photoImageView.image = photo
        photoImageView.contentMode = .scaleAspectFit
        
        drawingSlate = MGDrawingSlate()//(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.width - 20, height: self.view.frame.height - 190)))
        drawingSlate.backgroundColor = UIColor.clear
        drawingSlate.changeColor(to: UIColor.white)
        drawingSlate.changeLineWeight(to: weight)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        self.view.addSubview(groundView)
        self.view.addSubview(slider)
        self.view.addSubview(sliderLabel)
        self.view.addSubview(photoImageView)
        self.view.addSubview(drawingSlate)
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
        photoImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.left.equalTo(self.view).offset(10)
            make.top.equalTo(self.view).offset(10)
            make.bottom.equalTo(self.view).offset(-50)
        }
        drawingSlate.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.left.equalTo(self.view).offset(10)
            make.top.equalTo(self.view).offset(10)
            make.bottom.equalTo(self.view).offset(-110)
        }
        photoImageView.image = photo
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
    func weightSlider()
    {
        self.groundView.isHidden = false
        self.slider.isHidden = false
        self.sliderLabel.isHidden = false
        sliderLabel.text = "笔粗"
        slider.value = Float(weight)
        slider.minimumValue = 0
        slider.maximumValue = 20
        slider.isContinuous = false
    }
    func sliderValueChanged()
    {
        weight = Int(slider.value)
        drawingSlate.changeLineWeight(to: weight)
    }
    func backToLast()
    {
        let _ = self.navigationController?.popViewController(animated: true)
    }
}


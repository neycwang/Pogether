//
//  MovableImageView.swift
//  Pogether
//
//  Created by KiraMelody on 2017/2/20.
//  Copyright © 2017年 KiraMelody. All rights reserved.
//

import UIKit

public class MovableImageView: UIImageView, UIGestureRecognizerDelegate {
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override init(image: UIImage?) {
        super.init(image: image)
        isUserInteractionEnabled = true
        movableGestureRecognizers.forEach(addGestureRecognizer)
    }
    public var movableGestureRecognizers: [UIGestureRecognizer] {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragGesture(sender:)))
        let rotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(rotateGesture(sender:)))
        rotationGestureRecognizer.delegate = self
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinchGesture(sender:)))
        pinchGestureRecognizer.delegate = self
        
        return [panGestureRecognizer, rotationGestureRecognizer, pinchGestureRecognizer]
    }
    @objc func dragGesture(sender: UIPanGestureRecognizer) {
        let transform = self.transform
        self.transform = CGAffineTransform.identity
        let point = sender.translation(in: self)
        let movedPoint = CGPoint(x: center.x + point.x, y: center.y + point.y)
        center = movedPoint
        self.transform = transform
        sender.setTranslation(CGPoint.zero, in: self)
    }
    @objc func rotateGesture(sender: UIRotationGestureRecognizer) {
        self.transform = self.transform.concatenating(CGAffineTransform(rotationAngle: sender.rotation))
        sender.rotation = 0.0
    }
    @objc func pinchGesture(sender: UIPinchGestureRecognizer) {
        let transform = self.transform
        self.transform = CGAffineTransform.identity
        let scale = sender.scale
        let center = self.center
        frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width * scale, height: frame.height * scale)
        self.center = center
        self.transform = transform
        sender.scale = 1.0
    }
    @nonobjc public func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return (gestureRecognizer is UIRotationGestureRecognizer || gestureRecognizer is UIPinchGestureRecognizer) && (otherGestureRecognizer is UIRotationGestureRecognizer || otherGestureRecognizer is UIPinchGestureRecognizer)
    }
}

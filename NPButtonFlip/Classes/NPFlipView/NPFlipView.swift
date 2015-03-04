//
//  FlipView.swift
//  testFlip
//
//  Created by Glibert Axel on 11/11/14.
//  Copyright (c) 2014 Neopixl. All rights reserved.
//

import UIKit

public class NPFlipView: UIControl {
    
    private var frontImageView=UIImageView()
    private var backImageView=UIImageView()
    private var backDisplayed = false
    
    private var completionBlock:(()->Void)?
    
    
    //MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(frontImageView)
        self.addSubview(backImageView)
    }
    
    override init() {
        super.init()
        
        self.addSubview(frontImageView)
        self.addSubview(backImageView)
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.addSubview(frontImageView)
        self.addSubview(backImageView)
    }
    
    //MARK: set front and back Images
    public func setImages(frontImage:UIImage, backImage:UIImage) {
        
        self.frontImageView.image = frontImage
        self.frontImageView.frame.size = frontImage.size
        self.backImageView.image = backImage
        self.backImageView.frame.size = backImage.size
        
        self.enableSadow()
    }
    
    //MARK: Disable Shadow on Image
    
    public func disableShadow()
    {
        self.frontImageView.layer.shadowColor = nil
        self.frontImageView.layer.shadowOpacity = 1
        self.frontImageView.layer.shadowOffset = CGSize()
        self.frontImageView.layer.shadowRadius = 0
        self.frontImageView.layer.masksToBounds = false
        self.frontImageView.layer.zPosition = 0
        self.frontImageView.layer.shouldRasterize = true
        
        
        self.backImageView.layer.shadowColor = nil
        self.backImageView.layer.shadowOpacity = 1
        self.backImageView.layer.shadowOffset = CGSize()
        self.backImageView.layer.shadowRadius = 0
        self.backImageView.layer.masksToBounds = false
        self.backImageView.layer.zPosition = 0
        self.backImageView.layer.shouldRasterize = true
    }
    
    //MARK: Enable Shadow on Image
    public func enableSadow()
    {
        self.frontImageView.layer.shadowColor = UIColor.blackColor().CGColor
        self.frontImageView.layer.shadowOpacity = 0.25
        self.frontImageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.frontImageView.layer.shadowRadius = 2
        self.frontImageView.layer.masksToBounds = false
        self.frontImageView.layer.zPosition = -1
        self.frontImageView.layer.shouldRasterize = true
        
        self.backImageView.layer.shadowColor = UIColor.blackColor().CGColor
        self.backImageView.layer.shadowOpacity = 0.25
        self.backImageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.backImageView.layer.shadowRadius = 2
        self.backImageView.layer.masksToBounds = false
        self.backImageView.layer.zPosition = -1
        self.backImageView.layer.shouldRasterize = true
    }
    
    //MARK: touches Management
    
    override public func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.sendActionsForControlEvents(UIControlEvents.TouchDown)
    }
    
    override public func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        self.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
    }
    
    //MARK: flip
    
    public func flip(animated:Bool, duration:NSTimeInterval, completionBlock:(()->Void)!)
    {
        if animated
        {
            UIView.transitionWithView(self, duration: 0.3, options: UIViewAnimationOptions.TransitionFlipFromRight, animations: { () -> Void in
                //animations
                if !self.backDisplayed
                {
                    self.backImageView.removeFromSuperview()
                    self.addSubview(self.frontImageView)
                }
                else
                {
                    self.frontImageView.removeFromSuperview()
                    self.addSubview(self.backImageView)
                }
                self.backDisplayed = !self.backDisplayed
                }) { (finished) -> Void in
                    if let block = completionBlock {
                        block()
                    }
            }
        }
        else
        {
            if !self.backDisplayed
            {
                self.backImageView.removeFromSuperview()
                self.addSubview(self.frontImageView)
            }
            else
            {
                self.frontImageView.removeFromSuperview()
                self.addSubview(self.backImageView)
            }
            if let block = completionBlock {
                block()
            }
        }
    }
    
    
    
    public func flip(animated:Bool, duration:NSTimeInterval, toBack:Bool, completionBlock:((Bool)->Void)!)
    {
        if(toBack != backDisplayed)
        {
            if animated
            {
                UIView.transitionWithView(self, duration: 0.3, options: UIViewAnimationOptions.TransitionFlipFromRight, animations: { () -> Void in
                    //animations
                    if toBack
                    {
                        self.backImageView.removeFromSuperview()
                        self.addSubview(self.frontImageView)
                    }
                    else
                    {
                        self.frontImageView.removeFromSuperview()
                        self.addSubview(self.backImageView)
                    }
                    self.backDisplayed = toBack
                    }) { (finished) -> Void in
                        if let block = completionBlock {
                            block(finished)
                        }
                }
            }
            else
            {
                if toBack
                {
                    self.backImageView.removeFromSuperview()
                    self.addSubview(self.frontImageView)
                }
                else
                {
                    self.frontImageView.removeFromSuperview()
                    self.addSubview(self.backImageView)
                }
                self.backDisplayed = toBack
                if let block = completionBlock {
                    block(true)
                }
            }
        }
    }
}

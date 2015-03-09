/*
Copyright 2015 NEOPIXL S.A.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import UIKit

public class NPButtonWithFilp: UIControl {
    
    var borderColor:UIColor!
    var offColor:UIColor!
    var onColor:UIColor!
    
    private var flipButton:NPFlipView!
    var flipOffImage:UIImage!
    var flipOnImage:UIImage!
    var text:String!
    var textFont:UIFont!
    private var currentOff = true
    
    private var label:UILabel!
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
    override init()
    {
        super.init()
        initComponents()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initComponents()
    }
    
    private func initComponents()
    {
        self.label = UILabel()
        self.flipButton = NPFlipView(frame: CGRect(x: 0, y: 0, width: 32, height: 36))
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        flipButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(label)
        self.addSubview(flipButton)
        
        let labelCenterYConstraint = NSLayoutConstraint(item:label,
            attribute:NSLayoutAttribute.CenterY,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.CenterY,
            multiplier:1,
            constant:0)
        self.addConstraint(labelCenterYConstraint)
        
        let labelPinLeftBorderConstraint = NSLayoutConstraint(item:label,
            attribute:NSLayoutAttribute.Leading,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Leading,
            multiplier:1,
            constant:15)
        self.addConstraint(labelPinLeftBorderConstraint)
        
        let flipCenterYConstraint = NSLayoutConstraint(item:flipButton,
            attribute:NSLayoutAttribute.CenterY,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.CenterY,
            multiplier:1,
            constant:2)
        self.addConstraint(flipCenterYConstraint)
        
        let flipPinLeftBorderConstraint = NSLayoutConstraint(item:flipButton,
            attribute:NSLayoutAttribute.Trailing,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Trailing,
            multiplier:1,
            constant:-10)
        self.addConstraint(flipPinLeftBorderConstraint)
        
    }
    
    public func setParameters(borderColor:UIColor, offColor:UIColor, onColor:UIColor, flipOffImage:UIImage, flipOnImage:UIImage, text:String, textFont:UIFont)
    {
        self.borderColor = borderColor
        self.offColor = offColor
        self.onColor = onColor
        self.flipOffImage = flipOffImage
        self.flipOnImage = flipOnImage
        self.text = text
        label.text = self.text
        self.textFont = textFont
        label.font = self.textFont
        label.textColor = self.onColor
        
        self.layer.borderColor = self.borderColor.CGColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 2
        self.backgroundColor = offColor
        
        flipButton.setImages(self.flipOnImage, backImage: self.flipOffImage)
        flipButton.addTarget(self, action: "flipTouchDown", forControlEvents: UIControlEvents.TouchDown)
        flipButton.addTarget(self, action: "flipTouchUpInside", forControlEvents: UIControlEvents.TouchUpInside)
        
        flipButton.removeConstraints(flipButton.constraints())
        
        var viewDict = [ "view" : flipButton ] as Dictionary<NSObject,AnyObject>
        //+4 for shadow
        let vConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[view(\(flipOffImage.size.height+4))]", options: nil, metrics: nil, views: viewDict)
        flipButton.addConstraints(vConstraints)
        let hConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:[view(\(flipOffImage.size.width))]", options: nil, metrics: nil, views: viewDict)
        flipButton.addConstraints(hConstraints)
    }
    
    public func setState (on:Bool,animated:Bool)
    {
        if(currentOff == on)
        {
            if !on
            {
                if animated
                {
                    UIView.animateWithDuration(0.2, animations: { () -> Void in
                        self.backgroundColor = self.offColor
                        self.label.textColor = self.onColor
                    })
                }
                else
                {
                    self.backgroundColor = self.offColor
                    self.label.textColor = self.onColor
                }
            }
            else
            {
                if animated
                {
                    UIView.animateWithDuration(0.2, animations: { () -> Void in
                        self.backgroundColor = self.onColor
                        self.label.textColor = self.offColor
                    })
                }
                else
                {
                    self.backgroundColor = self.onColor
                    self.label.textColor = self.offColor
                }
            }
            self.flipButton.flip(animated, duration: 0.3, toBack: on, completionBlock: nil)
            self.currentOff = !on
        }
    }
    
    override public func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        didBegin()
    }
    
    private func didBegin()
    {
        if self.currentOff
        {
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.backgroundColor = self.onColor
                self.label.textColor = self.offColor
            })
        }
        else
        {
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.backgroundColor = self.offColor
                self.label.textColor = self.onColor
            })
        }
        self.currentOff = !self.currentOff
        
        self.sendActionsForControlEvents(UIControlEvents.TouchDown)
    }
    
    override public func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        didEnd()
    }
    
    private func didEnd()
    {
        self.flipButton.flip(true, duration: 0.3, completionBlock: nil)
        self.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
    }
    
    internal func flipTouchUpInside()
    {
        didEnd()
    }
    
    internal func flipTouchDown()
    {
        didBegin()
    }
}

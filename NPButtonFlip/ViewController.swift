//
//  ViewController.swift
//  NPButtonFlip
//
//  Created by Glibert Axel on 30/12/14.
//  Copyright (c) 2014 Neopixl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var buttonBig: NPButtonWithFilp!
    @IBOutlet weak var buttonLeft: NPButtonWithFilp!
    @IBOutlet weak var buttonRight: NPButtonWithFilp!
    @IBOutlet weak var labelAction: UILabel!
    @IBOutlet weak var flipLeft: NPFlipView!
    @IBOutlet weak var flipRight: NPFlipView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let textFont = UIFont(name: "HelveticaNeue-Light", size: 16)
        {
            if let imageOff = UIImage(named: "btn_right_off")
            {
                if let imageOn = UIImage(named: "btn_right_on")
                {
                    let borderColor = UIColor(white: 230/255, alpha: 1)
                    let offColor = UIColor.whiteColor()
                    let onColor = UIColor(red: 93/255, green: 202/255, blue: 115/255, alpha: 1)
                    buttonBig.setParameters(borderColor, offColor: offColor, onColor: onColor, flipOffImage: imageOff, flipOnImage: imageOn, text: "This is good", textFont: textFont)
                    buttonRight.setParameters(borderColor, offColor: offColor, onColor: onColor, flipOffImage: imageOff, flipOnImage: imageOn, text: "Good", textFont: textFont)
                    
                    //Frame of the NPFlipView must be a little bigger than the image to not crop the shadow animation if shadow is used (by default it's used)
                    flipRight.setImages(imageOff, backImage:imageOn)
                    
                }
            }
            
            if let imageOff = UIImage(named: "btn_wrong_off")
            {
                if let imageOn = UIImage(named: "btn_wrong_on")
                {
                    let borderColor = UIColor(white: 230/255, alpha: 1)
                    let offColor = UIColor.whiteColor()
                    let onColor = UIColor(red: 222/255, green: 142/255, blue: 92/255, alpha: 1)
                    buttonLeft.setParameters(borderColor, offColor: offColor, onColor: onColor, flipOffImage: imageOff, flipOnImage: imageOn, text: "Bad", textFont: textFont)
                    
                    //Frame of the NPFlipView must be a little bigger than the image to not crop the shadow animation if shadow is used (by default it's used)
                    flipLeft.setImages(imageOff, backImage:imageOn)
                    flipLeft.disableShadow()
                }
            }

        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Buttons Actions
    
    @IBAction func buttonBigTouchUpInside(sender: AnyObject) {
        labelAction.text = "Action : This is good TouchUpInside"
    }
    
    @IBAction func buttonBigTouchDown(sender: AnyObject) {
        labelAction.text = "Action : This is good TouchDown"
    }
    
    @IBAction func buttonLeftTouchUpInside(sender: AnyObject) {
        labelAction.text = "Action : Bad TouchUpInside"
    }
    
    @IBAction func buttonLeftTouchDown(sender: AnyObject) {
        labelAction.text = "Action : Bad TouchDown"
    }
    
    @IBAction func buttonRightTouchUpInside(sender: AnyObject) {
        labelAction.text = "Action : Good TouchUpInside"
    }
    
    @IBAction func buttonRightTouchDown(sender: AnyObject) {
        labelAction.text = "Action : Good TouchDown"
    }
    
    @IBAction func flipViewLeftTouchUpInside(sender: AnyObject) {
        labelAction.text = "Action : flipLeft TouchUpInside"
        //flip the flipLeft and when finished, display a alert.
        flipLeft.flip(true, duration: 0.3, completionBlock: { () -> Void in
            var refreshAlert = UIAlertView()
            refreshAlert.title = "Finished"
            refreshAlert.message = "Flip finished."
            refreshAlert.addButtonWithTitle("OK")
            refreshAlert.show()
        })
    }
    
    @IBAction func flipViewLeftTouchDown(sender: AnyObject) {
        labelAction.text = "Action : flipLeft TouchDown"
    }
    
    @IBAction func flipViewRightTouchUpInside(sender: AnyObject) {
        labelAction.text = "Action : flipRight TouchUpInside"
        //flip the flipRight and when finished, display a alert.
        flipRight.flip(true, duration: 0.3, { () -> Void in
            var refreshAlert = UIAlertView()
            refreshAlert.title = "Finished"
            refreshAlert.message = "Flip finished."
            refreshAlert.addButtonWithTitle("OK")
            refreshAlert.show()
        })
    }
    
    @IBAction func flipViewRightTouchDown(sender: AnyObject) {
        labelAction.text = "Action : flipRight TouchDown"
    }
    
    @IBAction func toBack(sender: AnyObject) {
        //flip all flip to back
        flipRight.flip(true, duration: 0.3, toBack:true, completionBlock: nil)
        flipLeft.flip(true, duration: 0.3, toBack:true, completionBlock: nil)
    }
    @IBAction func toFront(sender: AnyObject) {
        //flip all flip to front
        flipRight.flip(true, duration: 0.3, toBack:false, completionBlock: nil)
        flipLeft.flip(true, duration: 0.3, toBack:false, completionBlock: nil)
    }
    @IBAction func on(sender: AnyObject) {
        //set all button to on
        buttonRight.setState(true, animated: true)
        buttonLeft.setState(true, animated: true)
        buttonBig.setState(true, animated: true)
    }
    @IBAction func off(sender: AnyObject) {
        //set all button to off
        buttonRight.setState(false, animated: true)
        buttonLeft.setState(false, animated: true)
        buttonBig.setState(false, animated: true)
    }
}


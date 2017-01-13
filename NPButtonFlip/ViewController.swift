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
		
        if let textFont = UIFont(name: "HelveticaNeue-Light", size: 16) {
            if let imageOff = UIImage(named: "btn_right_off") {
                if let imageOn = UIImage(named: "btn_right_on") {
                    let borderColor = UIColor(white: 230/255, alpha: 1)
                    let offColor = UIColor.white
                    let onColor = UIColor(red: 93/255, green: 202/255, blue: 115/255, alpha: 1)
					buttonBig.setParameters(borderColor: borderColor, offColor: offColor, onColor: onColor, flipOffImage: imageOff, flipOnImage: imageOn, text: "This is good", textFont: textFont)
					buttonRight.setParameters(borderColor: borderColor, offColor: offColor, onColor: onColor, flipOffImage: imageOff, flipOnImage: imageOn, text: "Good", textFont: textFont)

                    //Frame of the NPFlipView must be a little bigger than the image to not crop the shadow animation if shadow is used (by default it's used)
					flipRight.setImages(frontImage: imageOff, backImage: imageOn)
                }
            }

            if let imageOff = UIImage(named: "btn_wrong_off") {
                if let imageOn = UIImage(named: "btn_wrong_on") {
                    let borderColor = UIColor(white: 230/255, alpha: 1)
                    let offColor = UIColor.white
                    let onColor = UIColor(red: 222/255, green: 142/255, blue: 92/255, alpha: 1)
					buttonLeft.setParameters(borderColor: borderColor, offColor: offColor, onColor: onColor, flipOffImage: imageOff, flipOnImage: imageOn, text: "Bad", textFont: textFont)

                    //Frame of the NPFlipView must be a little bigger than the image to not crop the shadow animation if shadow is used (by default it's used)
					flipLeft.setImages(frontImage: imageOff, backImage: imageOn)
                    flipLeft.disableShadow()
                }
            }

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Buttons Actions

    @IBAction func buttonBigTouchUpInside(_ sender: Any) {
        labelAction.text = "Action : This is good TouchUpInside"
    }

    @IBAction func buttonBigTouchDown(_ sender: Any) {
        labelAction.text = "Action : This is good TouchDown"
    }

    @IBAction func buttonLeftTouchUpInside(_ sender: Any) {
        labelAction.text = "Action : Bad TouchUpInside"
    }

    @IBAction func buttonLeftTouchDown(_ sender: Any) {
        labelAction.text = "Action : Bad TouchDown"
    }

    @IBAction func buttonRightTouchUpInside(_ sender: Any) {
        labelAction.text = "Action : Good TouchUpInside"
    }

    @IBAction func buttonRightTouchDown(_ sender: Any) {
        labelAction.text = "Action : Good TouchDown"
    }

    @IBAction func flipViewLeftTouchUpInside(_ sender: Any) {
        labelAction.text = "Action : flipLeft TouchUpInside"
        //flip the flipLeft and when finished, display a alert.
        flipLeft.flip(animated: true, duration: 0.3, completionBlock: { () -> Void in
            let refreshAlert = UIAlertView()
            refreshAlert.title = "Finished"
            refreshAlert.message = "Flip finished."
			refreshAlert.addButton(withTitle: "OK")
            refreshAlert.show()
        })
    }

    @IBAction func flipViewLeftTouchDown(_ sender: Any) {
        labelAction.text = "Action : flipLeft TouchDown"
    }

    @IBAction func flipViewRightTouchUpInside(_ sender: Any) {
        labelAction.text = "Action : flipRight TouchUpInside"
        //flip the flipRight and when finished, display a alert.
        flipRight.flip(animated: true, duration: 0.3, completionBlock: { () -> Void in
            let refreshAlert = UIAlertView()
            refreshAlert.title = "Finished"
            refreshAlert.message = "Flip finished."
			refreshAlert.addButton(withTitle: "OK")
            refreshAlert.show()
        })
    }

    @IBAction func flipViewRightTouchDown(_ sender: Any) {
        labelAction.text = "Action : flipRight TouchDown"
    }

    @IBAction func toBack(_ sender: Any) {
        //flip all flip to back
        flipRight.flip(animated: true, duration: 0.3, toBack:true, completionBlock: nil)
        flipLeft.flip(animated: true, duration: 0.3, toBack:true, completionBlock: nil)
    }
    @IBAction func toFront(_ sender: Any) {
        //flip all flip to front
        flipRight.flip(animated: true, duration: 0.3, toBack:false, completionBlock: nil)
        flipLeft.flip(animated: true, duration: 0.3, toBack:false, completionBlock: nil)
    }
    @IBAction func on(_ sender: Any) {
        //set all button to on
		buttonRight.setState(on: true, animated: true)
		buttonLeft.setState(on: true, animated: true)
		buttonBig.setState(on: true, animated: true)
    }
    @IBAction func off(_ sender: Any) {
        //set all button to off
		buttonRight.setState(on: false, animated: true)
		buttonLeft.setState(on: false, animated: true)
		buttonBig.setState(on: false, animated: true)
    }
}

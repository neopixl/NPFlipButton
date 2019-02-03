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

	var borderColor: UIColor!
	var offColor: UIColor!
	var onColor: UIColor!

	private var flipButton: NPFlipView!
	var flipOffImage: UIImage!
	var flipOnImage: UIImage!
	var text: String!
	var textFont: UIFont!

	private var currentOff = true

	private var label: UILabel!

	// MARK: - Init
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		initComponents()
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		initComponents()
	}

	// MARK: - Private methods

	private func initComponents() {
		self.label = UILabel()
		self.flipButton = NPFlipView(frame: CGRect(x: 0, y: 0, width: 32, height: 36))
		label.translatesAutoresizingMaskIntoConstraints = false
		flipButton.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(label)
		self.addSubview(flipButton)

		let labelCenterYConstraint = NSLayoutConstraint(item:label,
                                                        attribute:NSLayoutConstraint.Attribute.centerY,
                                                        relatedBy:NSLayoutConstraint.Relation.equal,
		                                                toItem:self,
                                                        attribute:NSLayoutConstraint.Attribute.centerY,
		                                                multiplier:1,
		                                                constant:0)
		self.addConstraint(labelCenterYConstraint)

		let labelPinLeftBorderConstraint = NSLayoutConstraint(item:label,
                                                              attribute:NSLayoutConstraint.Attribute.leading,
                                                              relatedBy:NSLayoutConstraint.Relation.equal,
		                                                      toItem:self,
                                                              attribute:NSLayoutConstraint.Attribute.leading,
		                                                      multiplier:1,
		                                                      constant:15)
		self.addConstraint(labelPinLeftBorderConstraint)

		let flipCenterYConstraint = NSLayoutConstraint(item:flipButton,
                                                       attribute:NSLayoutConstraint.Attribute.centerY,
                                                       relatedBy:NSLayoutConstraint.Relation.equal,
		                                               toItem:self,
                                                       attribute:NSLayoutConstraint.Attribute.centerY,
		                                               multiplier:1,
		                                               constant:2)
		self.addConstraint(flipCenterYConstraint)

		let flipPinLeftBorderConstraint = NSLayoutConstraint(item:flipButton,
                                                             attribute:NSLayoutConstraint.Attribute.trailing,
                                                             relatedBy:NSLayoutConstraint.Relation.equal,
		                                                     toItem:self,
                                                             attribute:NSLayoutConstraint.Attribute.trailing,
		                                                     multiplier:1,
		                                                     constant:-10)
		self.addConstraint(flipPinLeftBorderConstraint)

	}

	// MARK: - Public methods

	public func setParameters(borderColor: UIColor, offColor: UIColor, onColor: UIColor, flipOffImage: UIImage, flipOnImage: UIImage, text: String, textFont: UIFont) {
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

		self.layer.borderColor = self.borderColor.cgColor
		self.layer.borderWidth = 1
		self.layer.cornerRadius = 2
		self.backgroundColor = offColor

		flipButton.setImages(frontImage: flipOnImage, backImage: flipOffImage)
		flipButton.addTarget(self, action: #selector(flipTouchDown), for: .touchDown)
		flipButton.addTarget(self, action: #selector(flipTouchUpInside), for: .touchUpInside)

		flipButton.removeConstraints(flipButton.constraints)

		let views = ["view": flipButton]
		//+4 for shadow
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat:"V:[view(\(flipOffImage.size.height+4))]", options: [], metrics: nil, views: views as [String : Any])
		flipButton.addConstraints(verticalConstraints)

        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[view(\(flipOffImage.size.width))]", options: [], metrics: nil, views: views as [String : Any])
		flipButton.addConstraints(horizontalConstraints)
	}

	public func setState (on: Bool, animated: Bool) {
		if(currentOff == on) {
			if !on {
				if animated {
					UIView.animate(withDuration: 0.2, animations: {
						self.backgroundColor = self.offColor
						self.label.textColor = self.onColor
					})

				} else {
					self.backgroundColor = self.offColor
					self.label.textColor = self.onColor
				}
			} else {
				if animated {
					UIView.animate(withDuration: 0.2, animations: {
						self.backgroundColor = self.onColor
						self.label.textColor = self.offColor
					})
				} else {
					self.backgroundColor = self.onColor
					self.label.textColor = self.offColor
				}
			}
			self.flipButton.flip(animated: animated, duration: 0.3, toBack: on, completionBlock: nil)
			self.currentOff = !on
		}
	}

	public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		didBegin()
	}

	private func didBegin() {
		if self.currentOff {
			UIView.animate(withDuration: 0.2, animations: {
				self.backgroundColor = self.onColor
				self.label.textColor = self.offColor
			})
		} else {
			UIView.animate(withDuration: 0.2, animations: {
				self.backgroundColor = self.offColor
				self.label.textColor = self.onColor
			})
		}
		self.currentOff = !self.currentOff

		self.sendActions(for: .touchDown)
	}

	public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		didEnd()
	}

	private func didEnd() {
		self.flipButton.flip(animated: true, duration: 0.3, completionBlock: nil)
		self.sendActions(for: .touchUpInside)
	}

    @objc internal func flipTouchUpInside() {
		didEnd()
	}

    @objc internal func flipTouchDown() {
		didBegin()
	}
}

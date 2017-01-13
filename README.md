# NPFlipButton
![Version](https://img.shields.io/cocoapods/v/NPFlipButton.svg?style=flat)
![License](https://img.shields.io/cocoapods/l/NPFlipButton.svg?style=flat)
![Platform](https://img.shields.io/cocoapods/p/NPFlipButton.svg?style=flat)
***

This is a simple button with a circle at right, who will animate when changing state.

<img src = "https://github.com/neopixl/NPFlipButton/blob/master/Documentation/npflipbutton.gif?raw=true" />


## Features

- automatically draw the button and set its text
- animate the state change

## Installation

> **Embedded frameworks require a minimum deployment target of iOS 8.**
>
> To use NPFlipButton with a project targeting iOS 7, you must include the files in `Classes/NPButtonWithFlip` and `Classes/NPFlipView` directly in your project.
>

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

CocoaPods 0.36 adds supports for Swift and embedded frameworks. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate NPFlipButton into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'NPFlipButton'
```

***Swift 2 Support*** (only with version 1.0.0) :

```ruby
pod 'NPFlipButton', '~> 1.0.0'
```


Then, run the following command:

```bash
$ pod install
```

## Usage

Import NPFlipButton
```swift
import NPFlipButton
```
Instantiate a new NPButtonWithFlip or get it from a Storyboard
Configure the parameters:
```swift
button.setParameters(borderColor: borderColor, offColor: offColor, onColor: onColor, flipOffImage: imageOff, flipOnImage: imageOn, text: "Button", textFont: textFont)

```

## Small Print

### Author

[Neopixl](http://www.neopixl.com)

### License
-------------------------

Copyright 2015 Neopixl S.A. - Apache 2.0 licence. 

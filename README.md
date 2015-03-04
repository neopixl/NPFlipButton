# NPButtonFlip

***

This is a simple button with a circle at right, who will animate when changing state.


## Features

- automatically draw the button and set his text
- animate the state change

## Installation

Grab the files in `Classes/NPButtonWithFlip`, `Classes/NPFlipView` and put it in your
project. The code uses ARC, so make sure to turn that on for the files if you're
not already using ARC.

## Usage

Instanciate a new NPButtonWithFlip or get it from a Storyboard
Configure the parameters:
```swift
button.setParameters(borderColor, offColor: offColor, onColor: onColor, flipOffImage: imageOff, flipOnImage: imageOn, text: "Button", textFont: textFont)
```

## Small Print

### Author

[Neopixl](http://www.neopixl.com)

### License
-------------------------

Copyright 2015 Neopixl S.A. - Apache 2.0 licence. 
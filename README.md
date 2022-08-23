# Controls

SwiftUI Knobs, Sliders, X-Y Pads, and generic controls.

## Examples

* ArcKnob - knob controled by dragging along a circular path
* DualArcKnob - knob controlled by dragging away from the center (radial paramter) and along a circular path (angular parameter)
* IndexedSlider - Slider that controls an integer parameter and snaps to increments
* Joystick - XY control that snaps to center
* PitchModWheel - Vertical slider than can be a pitch wheel or mod wheel
* Scrubber - horizontal slider
* SimpleKnob - just a knob
* XYPad - XY control that doesn't snap

## Generic Controls

Since every app has its own style you can use the appropriate wrapper around your own drawing code and let us do the dragging math for you:


```swift
@State var volume: Float = 0
var range: ClosedRange<Float> = 0 ... 11

//... in your SwiftUI body ...
Control(geometry: .relativeRectilinear(ySensitivity: 2),
        value: $volume, 
        in: range) { geo in
          
    // Your code can use the geometry proxy to do layout
    // and use your state vars
}
```


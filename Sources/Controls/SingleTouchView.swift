import SwiftUI

public typealias TouchCallback = (CGPoint?) -> Void

#if os(iOS)

import UIKit

class SingleTouchViewIOS: UIView {

    var callback: TouchCallback = { _ in }
    var touches = Set<UITouch>()

    func averagePoint(_ touches: Set<UITouch>) -> CGPoint? {
        let touchArray = self.touches.map { $0.location(in: self)}
        if touchArray.count == 0 { return nil}

        var averagePoint = CGPoint.zero
        for touch in touchArray {
            averagePoint = CGPoint(x: averagePoint.x + touch.x,
                                   y: averagePoint.y + touch.y)
        }
        averagePoint = CGPoint(x: averagePoint.x / CGFloat(touchArray.count),
                               y: averagePoint.y / CGFloat(touchArray.count))

        return averagePoint
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touches.formUnion(touches)
        callback(averagePoint(self.touches))
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        callback(averagePoint(self.touches))
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touches.subtract(touches)
        callback(averagePoint(self.touches))
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touches.subtract(touches)
        callback(averagePoint(self.touches))
    }
}

struct SingleTouchView: UIViewRepresentable {

    var callback: TouchCallback = { _ in }

    func makeUIView(context: Context) -> SingleTouchViewIOS {
        let view = SingleTouchViewIOS()
        view.callback = callback
        view.isMultipleTouchEnabled = true
        return view
    }

    func updateUIView(_ uiView: SingleTouchViewIOS, context: Context) {
        uiView.callback = callback
    }
}

#else

import AppKit

class SingleTouchViewMacOS: NSView {

    var callback: TouchCallback = { _ in }

    func flip(_ p: CGPoint) -> CGPoint {
        CGPoint(x: p.x, y: frame.size.height - p.y)
    }

    override func mouseDown(with event: NSEvent) {
        callback(flip(convert(event.locationInWindow, from: nil)))
    }

    override func mouseDragged(with event: NSEvent) {
        callback(flip(convert(event.locationInWindow, from: nil)))
    }

    override func mouseUp(with event: NSEvent) {
        callback(nil)
    }

}

struct SingleTouchView: NSViewRepresentable {

    var callback: TouchCallback = { _ in }

    func makeNSView(context: Context) -> SingleTouchViewMacOS {
        let view = SingleTouchViewMacOS()
        view.callback = callback
        return view
    }

    func updateNSView(_ uiView: SingleTouchViewMacOS, context: Context) {
        uiView.callback = callback
    }
}

#endif

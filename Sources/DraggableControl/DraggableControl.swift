import SwiftUI

public typealias TouchCallback = (Double, Double)-> Void

struct DraggableControl: ViewModifier {

    @GestureState var touchLocation: CGPoint?
    var callback: TouchCallback

    func body(content: Content) -> some View {
        content
            .gesture(DragGesture(minimumDistance: 0)
                .updating($touchLocation) { value, state, _ in
                    state = value.location
                    callback(state!.x, state!.y)
                }
            )
    }
}

public extension View {
    func draggable(_ callback: @escaping TouchCallback) -> some View {
        modifier(DraggableControl(callback: callback))
    }
}

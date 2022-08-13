import SwiftUI

/// A view in which dragging on it will change bound variables and perform closures
/// TODO: Is this a good name?
public struct Draggable<Content: View>: View {
    let content: () -> Content
    var layout: ControlLayout
    var onStarted: () -> Void
    var onEnded: () -> Void
    @Binding var value1: Double
    @Binding var value2: Double

    @StateObject var model = DraggableModel()

    /// Initialize the draggable
    /// - Parameters:
    ///   - layout: Gesture movement geometry specification
    ///   - value1: First value that is controlled
    ///   - value2: Second value that is controlled
    ///   - onEnded: Closure to perform when the drag starts
    ///   - onEnded: Closure to perform when the drag finishes
    ///   - content: View to render
    public init(layout: ControlLayout = .rectilinear,
                value1: Binding<Double>,
                value2: Binding<Double>,
                onStarted: @escaping () -> Void = {},
                onEnded: @escaping () -> Void = {},
                @ViewBuilder content: @escaping () -> Content)
    {
        self.layout = layout
        self._value1 = value1
        self._value2 = value2
        self.onStarted = onStarted
        self.onEnded = onEnded
        self.content = content
    }

    /// Body enclosing the draggable container
    public var body: some View {
        DraggableContainer(model: model, onStarted: onStarted, onEnded: onEnded, content: content)
            .onPreferenceChange(TouchLocationKey.self) { touchLocation in
                model.touchLocation = touchLocation
            }
            .onPreferenceChange(RectKey.self) { rect in
                model.rect = rect
            }
            .onAppear {
                model.layout = layout
                model.value1 = _value1
                model.value2 = _value2
            }
    }
}

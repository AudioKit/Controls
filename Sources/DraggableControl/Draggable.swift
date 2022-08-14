import SwiftUI

/// A view in which dragging on it will change bound variables and perform closures
/// TODO: Is this a good name?
public struct Draggable<Content: View>: View {
    let content: () -> Content
    var layout: DraggableLayout
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
    public init(layout: DraggableLayout = .rectilinear,
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

    @State var hasStarted = false

    func rect(rect: CGRect) -> some View {
        content()
            .contentShape(Rectangle()) // Added to improve tap/click reliability
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onChanged { gesture in
                    if !hasStarted {
                        onStarted()
                    }
                    hasStarted = true
                    model.touchLocation = gesture.location
                }
                .onEnded { _ in
                    model.touchLocation = .zero
                    onEnded()
                    hasStarted = false
                }
            )
            .onAppear {
                model.layout = layout
                model.value1 = _value1
                model.value2 = _value2
                model.rect = rect
            }
    }

    public var body: some View {
        GeometryReader { proxy in
            rect(rect: proxy.frame(in: .local))
        }
    }

}

import SwiftUI

/// A view in which dragging on it will change bound variables and perform closures
/// TODO: Is this a good name?
public struct Draggable<Content: View>: View {
    let content: (GeometryProxy) -> Content
    var geometry: DraggableGeometry
    var onStarted: () -> Void
    var onEnded: () -> Void
    @Binding var value1: Double
    @Binding var value2: Double

    @State var hasStarted = false
    @State var rect: CGRect = .zero
    @State var touchLocation: CGPoint = .zero {
        didSet { calculateValuePairs(from: oldValue) }
    }

    /// Initialize the draggable
    /// - Parameters:
    ///   - geometry: Gesture movement geometry specification
    ///   - value1: First value that is controlled
    ///   - value2: Second value that is controlled
    ///   - onStarted: Closure to perform when the drag starts
    ///   - onEnded: Closure to perform when the drag finishes
    ///   - content: View to render
    public init(geometry: DraggableGeometry = .rectilinear,
                value1: Binding<Double> = .constant(0),
                value2: Binding<Double> = .constant(0),
                onStarted: @escaping () -> Void = {},
                onEnded: @escaping () -> Void = {},
                @ViewBuilder content: @escaping (GeometryProxy) -> Content)
    {
        self.geometry = geometry
        _value1 = value1
        _value2 = value2
        self.onStarted = onStarted
        self.onEnded = onEnded
        self.content = content
    }

    public var body: some View {
        GeometryReader { proxy in
            content(proxy)
                .contentShape(Rectangle()) // Added to improve tap/click reliability
                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onChanged { gesture in
                        if !hasStarted {
                            onStarted()
                            hasStarted = true
                        }
                        touchLocation = gesture.location
                    }
                    .onEnded { _ in
                        touchLocation = .zero
                        onEnded()
                        hasStarted = false
                    }
                )
                .onAppear {
                    rect = proxy.frame(in: .local)
                }
        }
    }
}

import SwiftUI

/// A view in which dragging on it will change bound variables and perform closures
public struct Draggable<Content: View>: View {
    let content: (GeometryProxy) -> Content
    var geometry: DraggableGeometry
    var onStarted: () -> Void
    var onEnded: () -> Void
    @Binding var value: Double
    @Binding var value2: Double
    var range1: ClosedRange<Double>
    var range2: ClosedRange<Double>

    @State var hasStarted = false
    @State var rect: CGRect = .zero
    @State var touchLocation: CGPoint = .zero {
        didSet {
            (value, value2) = geometry.calculateValuePair(value: value,
                                                          in: range1,
                                                          value2: value2,
                                                          inRange2: range2,
                                                          from: oldValue,
                                                          to: touchLocation,
                                                          inRect: rect)
        }
    }

    /// Initialize the draggable
    /// - Parameters:
    ///   - geometry: Gesture movement geometry specification
    ///   - value: First value that is controlled
    ///   - value2: Second value that is controlled
    ///   - onStarted: Closure to perform when the drag starts
    ///   - onEnded: Closure to perform when the drag finishes
    ///   - content: View to render
    public init(geometry: DraggableGeometry = .rectilinear,
                value: Binding<Double> = .constant(0),
                in range1: ClosedRange<Double> = 0 ... 1,
                value2: Binding<Double> = .constant(0),
                inRange2 range2: ClosedRange<Double> = 0 ... 1,
                onStarted: @escaping () -> Void = {},
                onEnded: @escaping () -> Void = {},
                @ViewBuilder content: @escaping (GeometryProxy) -> Content)
    {
        self.geometry = geometry
        _value = value
        _value2 = value2
        self.range1 = range1
        self.range2 = range2
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

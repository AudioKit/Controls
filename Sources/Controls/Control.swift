import SwiftUI

/// A view in which dragging on it will change bound variables and perform closures
public struct Control<Content: View>: View {
    let content: (GeometryProxy) -> Content
    var geometry: ControlGeometry
    var onStarted: () -> Void
    var onEnded: () -> Void
    @Binding var value: Float
    var range: ClosedRange<Float>

    @State var hasStarted = false
    @State var rect: CGRect = .zero
    @State var touchLocation: CGPoint = .zero {
        didSet {
            value = geometry.calculateValue(value: value,
                                            in: range,
                                            from: oldValue,
                                            to: touchLocation,
                                            inRect: rect)
        }
    }

    /// Initialize the draggable
    /// - Parameters:
    ///   - value: Value that is controlled
    ///   - in range: The limits of the value (defaults to 0-1)
    ///   - geometry: Gesture movement geometry specification
    ///   - onStarted: Closure to perform when the drag starts
    ///   - onEnded: Closure to perform when the drag finishes
    ///   - content: View to render
    public init(value: Binding<Float>,
                in range: ClosedRange<Float> = 0 ... 1,
                geometry: ControlGeometry = .twoDimensionalDrag(),
                onStarted: @escaping () -> Void = {},
                onEnded: @escaping () -> Void = {},
                @ViewBuilder content: @escaping (GeometryProxy) -> Content)
    {
        self.geometry = geometry
        _value = value
        self.range = range
        self.onStarted = onStarted
        self.onEnded = onEnded
        self.content = content
    }

    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                content(proxy)
                SingleTouchView { touch in
                    if let touch = touch {
                        if !hasStarted {
                            onStarted()
                            hasStarted = true
                        }
                        touchLocation = touch
                    } else {
                        touchLocation = .zero
                        onEnded()
                        hasStarted = false
                    }
                }
            }
            .onAppear {
                rect = proxy.frame(in: .local)
            }
            .onChange(of: proxy.size) { newValue in
                rect = proxy.frame(in: .local)
            }
        }
    }
}

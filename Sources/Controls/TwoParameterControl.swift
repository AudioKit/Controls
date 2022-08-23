import SwiftUI

/// A view in which dragging on it will change bound variables and perform closures
public struct TwoParameterControl<Content: View>: View {
    let content: (GeometryProxy) -> Content
    var geometry: PlanarGeometry
    var onStarted: () -> Void
    var onEnded: () -> Void
    @Binding var value1: Float
    @Binding var value2: Float
    var range1: ClosedRange<Float>
    var range2: ClosedRange<Float>

    @State var hasStarted = false
    @State var rect: CGRect = .zero
    @State var touchLocation: CGPoint = .zero {
        didSet {
            (value1, value2) = geometry.calculateValuePair(value1: value1,
                                                           range1: range1,
                                                           value2: value2,
                                                           range2: range2,
                                                           from: oldValue,
                                                           to: touchLocation,
                                                           inRect: rect)
        }
    }

    /// Initialize the draggable
    /// - Parameters:
    ///   - geometry: Gesture movement geometry specification
    ///   - value1: First value that is controlled
    ///   - value2: Second value that is controlled
    ///   - onStarted: Closure to perform when the drag starts
    ///   - onEnded: Closure to perform when the drag finishes
    ///   - content: View to render
    public init(value1: Binding<Float>,
                range1: ClosedRange<Float> = 0 ... 1,
                value2: Binding<Float>,
                range2: ClosedRange<Float> = 0 ... 1,
                geometry: PlanarGeometry = .rectilinear,
                onStarted: @escaping () -> Void = {},
                onEnded: @escaping () -> Void = {},
                @ViewBuilder content: @escaping (GeometryProxy) -> Content)
    {
        self.geometry = geometry
        _value1 = value1
        _value2 = value2
        self.range1 = range1
        self.range2 = range2
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

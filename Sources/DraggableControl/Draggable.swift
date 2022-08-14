import SwiftUI

/// A view in which dragging on it will change bound variables and perform closures
/// TODO: Is this a good name?
public struct Draggable<Content: View>: View {
    let content: () -> Content
    var geometry: DraggableGeometry
    var onStarted: () -> Void
    var onEnded: () -> Void
    @Binding var value1: Double
    @Binding var value2: Double

    /// Initialize the draggable
    /// - Parameters:
    ///   - geometry: Gesture movement geometry specification
    ///   - value1: First value that is controlled
    ///   - value2: Second value that is controlled
    ///   - onEnded: Closure to perform when the drag starts
    ///   - onEnded: Closure to perform when the drag finishes
    ///   - content: View to render
    public init(geometry: DraggableGeometry = .rectilinear,
                value1: Binding<Double>,
                value2: Binding<Double>,
                onStarted: @escaping () -> Void = {},
                onEnded: @escaping () -> Void = {},
                @ViewBuilder content: @escaping () -> Content)
    {
        self.geometry = geometry
        _value1 = value1
        _value2 = value2
        self.onStarted = onStarted
        self.onEnded = onEnded
        self.content = content
    }

    @State var hasStarted = false

    func drawDraggable(in rect: CGRect) -> some View {
        content()
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
                self.rect = rect
            }
    }

    public var body: some View {
        GeometryReader { proxy in
            drawDraggable(in: proxy.frame(in: .local))
        }
    }

    @State var rect: CGRect = .zero

    @State var touchLocation: CGPoint = .zero {
        didSet {
            guard touchLocation != .zero else { return }

            switch geometry {
            case .rectilinear:
                value1 = max(0.0, min(1.0, touchLocation.x / rect.size.width))
                value2 = 1.0 - max(0.0, min(1.0, touchLocation.y / rect.size.height))

            case let .relativeRectilinear(xSensitivity: xSensitivity, ySensitivity: ySensitivity):
                guard oldValue != .zero else { return }
                let temp1 = value1 + (touchLocation.x - oldValue.x) * xSensitivity / rect.size.width
                let temp2 = value2 - (touchLocation.y - oldValue.y) * ySensitivity / rect.size.height

                value1 = max(0, min(1, temp1))
                value2 = max(0, min(1, temp2))

            case let .polar(angularRange: angularRange):
                let polar = polarCoordinate(point: touchLocation)
                value1 = polar.radius
                let width = angularRange.upperBound.radians - angularRange.lowerBound.radians
                let value = (polar.angle.radians - angularRange.lowerBound.radians) / width
                value2 = max(0.0, min(1.0, value))

            case let .relativePolar(radialSensitivity: radialSensitivity):
                guard oldValue != .zero else { return }
                let oldPolar = polarCoordinate(point: oldValue)
                let newPolar = polarCoordinate(point: touchLocation)

                let temp1 = value1 + (newPolar.radius - oldPolar.radius) * radialSensitivity
                let temp2 = value2 + (newPolar.angle.radians - oldPolar.angle.radians) / (2.0 * .pi)

                value1 = max(0, min(1, temp1))
                value2 = max(0, min(1, temp2))
            }
        }
    }

    func polarCoordinate(point: CGPoint) -> PolarCoordinate {
        // Calculate the x and y distances from the center
        let deltaX = (point.x - rect.midX) / (rect.width / 2.0)
        let deltaY = (point.y - rect.midY) / (rect.height / 2.0)

        // Convert to polar
        let radius = max(0.0, min(1.0, sqrt(pow(deltaX, 2) + pow(deltaY, 2))))
        var theta = atan(deltaY / deltaX)

        // Math to rotate to clockwise polar from -y axis (most like a knob)
        theta += .pi * (deltaX > 0 ? 1.5 : 0.5)

        return PolarCoordinate(radius: radius, angle: Angle(radians: theta))
    }
}

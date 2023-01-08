import SwiftUI

/// Polar coordinate control
public struct Joystick: View {
    @Binding var radius: Float
    @Binding var angle: Float

    var backgroundColor: Color = .gray
    var foregroundColor: Color = .red

    func ended() { radius = 0 }

    /// Initialize the joystick with radial and angular parameter
    /// - Parameters:
    ///   - radius: value bound to the distance from zero
    ///   - angle: value bound to the angle
    public init(radius: Binding<Float>, angle: Binding<Float>) {
        _radius = radius
        _angle = angle
    }

    public var body: some View {
        TwoParameterControl(value1: $radius,
                            value2: $angle,
                            geometry: .polar(),
                            onEnded: ended) { geo in
            ZStack(alignment: .center) {
                Circle().foregroundColor(backgroundColor)
                Circle().foregroundColor(foregroundColor)
                    .frame(width: geo.size.width / 10, height: geo.size.height / 10)
                    .offset(x: CGFloat(-radius * sin(angle * 2.0 * .pi)) * geo.size.width / 2.0,
                            y: CGFloat(radius * cos(angle * 2.0 * .pi)) * geo.size.height / 2.0)
                    .animation(.spring(response: 0.1), value: radius)
            }
        }
    }
}

extension Joystick {
    /// Modifier to change the background color of the joystick
    /// - Parameter backgroundColor: background color
    public func backgroundColor(_ backgroundColor: Color) -> Joystick {
        var copy = self
        copy.backgroundColor = backgroundColor
        return copy
    }

    /// Modifier to change the foreground color of the joystick
    /// - Parameter foregroundColor: foreground color
    public func foregroundColor(_ foregroundColor: Color) -> Joystick {
        var copy = self
        copy.foregroundColor = foregroundColor
        return copy
    }
}

import SwiftUI

public struct SimpleKnob: View {
    @Binding var value: Float
    var range: ClosedRange<Float> = 0.0 ... 1.0

    var backgroundColor: Color = .gray
    var foregroundColor: Color = .red

    public init(value: Binding<Float>, range: ClosedRange<Float> = 0.0 ... 1.0) {
        _value = value
        self.range = range
    }

    var normalizedValue: Double {
        Double((value - range.lowerBound) / (range.upperBound - range.lowerBound))
    }

    public var body: some View {
        Control(value: $value, in: range,
                geometry: .twoDimensionalDrag(xSensitivity: 1, ySensitivity: 1)) { geo in
            ZStack(alignment: .center) {
                Ellipse().foregroundColor(backgroundColor)
                Rectangle().foregroundColor(foregroundColor)
                    .frame(width: geo.size.width / 20, height: geo.size.height / 4)
                    .rotationEffect(Angle(radians: normalizedValue * 1.6 * .pi + 0.2 * .pi))
                    .offset(x: -sin(normalizedValue * 1.6 * .pi + 0.2 * .pi) * geo.size.width / 2.0 * 0.75,
                            y: cos(normalizedValue * 1.6 * .pi + 0.2 * .pi) * geo.size.height / 2.0 * 0.75)
            }
        }
        .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)

    }
}


extension SimpleKnob {
    internal init(value: Binding<Float>,
                  backgroundColor: Color,
                  foregroundColor: Color) {
        self._value = value
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }


    /// Modifer to change the background color of the slider
    /// - Parameter backgroundColor: background color
    public func backgroundColor(_ backgroundColor: Color) -> SimpleKnob {
        return .init(value: _value,
                     backgroundColor: backgroundColor,
                     foregroundColor: foregroundColor)
    }

    /// Modifer to change the foreground color of the slider
    /// - Parameter foregroundColor: foreground color
    public func foregroundColor(_ foregroundColor: Color) -> SimpleKnob {
        return .init(value: _value,
                     backgroundColor: backgroundColor,
                     foregroundColor: foregroundColor)
    }
}

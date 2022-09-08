import SwiftUI

public struct ArcKnob: View {
    @Binding var value: Float
    var rangeDegrees = 270.0
    var text = ""

    var backgroundColor: Color = .gray
    var foregroundColor: Color = .red

    @State var isShowingValue = false
    var range: ClosedRange<Float> = 0.0 ... 1.0

    public init(_ text: String, value: Binding<Float>, range: ClosedRange<Float> = 0 ... 100) {
        _value = value
        self.text = text
        self.range = range
    }

    func dim(_ proxy: GeometryProxy) -> CGFloat {
        min(proxy.size.width, proxy.size.height)
    }

    public var body: some View {
        Control(value: $value, in: range,
                geometry: .angle(angularRange: Angle(degrees: 45) ... Angle(degrees: 315)),
                onStarted: { isShowingValue = true },
                onEnded: { isShowingValue = false }) { geo in
            ZStack(alignment: .center) {
                Circle()
                    .trim(from: 45.0 / 360.0, to: 315.0 / 360.0)
                    .rotation(.degrees(-rangeDegrees))
                    .stroke(backgroundColor,
                            style: StrokeStyle(lineWidth: dim(geo) / 10,
                                               lineCap: .round))
                    .squareFrame(dim(geo) * 0.8)
                    .foregroundColor(foregroundColor)

                // Stroke value trim of knob
                Circle()
                    .trim(from: 45 / 360.0, to: (45 + Double(value) / 100.0 * rangeDegrees) / 360.0)
                    .rotation(.degrees(-rangeDegrees))
                    .stroke(foregroundColor,
                            style: StrokeStyle(lineWidth: dim(geo) / 10,
                                               lineCap: .round))
                    .squareFrame(dim(geo) * 0.8)

                Text("\(isShowingValue ? "\(Int(value))" : text)")
                    .frame(width: dim(geo) * 0.8)
                    .font(Font.system(size: dim(geo) * 0.2, weight: .bold))
                    .foregroundColor(backgroundColor)
            }
        }
    }
}


extension ArcKnob {
    internal init(text: String,
                  value: Binding<Float>,
                  range: ClosedRange<Float> = 0.0 ... 1.0,
                  backgroundColor: Color,
                  foregroundColor: Color) {
        self._value = value
        self.text = text
        self.range = range
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }


    /// Modifer to change the background color of the slider
    /// - Parameter backgroundColor: background color
    public func backgroundColor(_ backgroundColor: Color) -> ArcKnob {
        return .init(text: text,
                     value: _value,
                     range: range,
                     backgroundColor: backgroundColor,
                     foregroundColor: foregroundColor)
    }

    /// Modifer to change the foreground color of the slider
    /// - Parameter foregroundColor: foreground color
    public func foregroundColor(_ foregroundColor: Color) -> ArcKnob {
        return .init(text: text,
                     value: _value,
                     range: range,
                     backgroundColor: backgroundColor,
                     foregroundColor: foregroundColor)
    }
}

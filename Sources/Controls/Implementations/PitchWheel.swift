import SwiftUI

/// Pitch wheel for a keyboard
public struct PitchWheel: View {

    @Binding var location: Float

    var backgroundColor: Color = .gray
    var foregroundColor: Color = .red
    var cornerRadius: CGFloat = 0
    var indicatorPadding: CGFloat = 0.07
    var indicatorHeight: CGFloat = 40

    /// Initial the wheel with a type and bound value
    /// - Parameter value: value to control
    public init(value: Binding<Float>) {
        _location = value
    }

    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius).foregroundColor(backgroundColor)
            Control(value: $location,
                    geometry: .verticalPoint,
                    padding: CGSize(width: 0, height: indicatorHeight / 2),
                    onEnded: { location = 0.5 }) { geo in
                Canvas { cx, size in
                    let viewport = CGRect(origin: .zero, size: size)
                    let indicatorRect = CGRect(origin: .zero,
                                               size: CGSize(width: geo.size.width - geo.size.width * indicatorPadding * 2,
                                                            height: indicatorHeight - geo.size.width * indicatorPadding * 2))

                    let activeHeight = viewport.size.height - indicatorRect.size.height

                    let offsetRect = indicatorRect
                        .offset(by: CGSize(width: 0,
                                           height: activeHeight * (1 - CGFloat(location))))
                    let cr = min(indicatorRect.height / 2, cornerRadius)
                    let ind = Path(roundedRect: offsetRect, cornerRadius: cr)

                    cx.fill(ind, with: .color(foregroundColor))
                }
                .animation(.spring(response: 0.2), value: location)
                .padding(geo.size.width * indicatorPadding)
            }
        }
        .onAppear {
            location = 0.5
        }
    }
}

extension PitchWheel {
    /// Modifier to change the background color of the wheel
    /// - Parameter backgroundColor: background color
    public func backgroundColor(_ backgroundColor: Color) -> PitchWheel {
        var copy = self
        copy.backgroundColor = backgroundColor
        return copy
    }

    /// Modifier to change the foreground color of the wheel
    /// - Parameter foregroundColor: foreground color
    public func foregroundColor(_ foregroundColor: Color) -> PitchWheel {
        var copy = self
        copy.foregroundColor = foregroundColor
        return copy
    }

    /// Modifier to change the corner radius of the wheel and the indicator
    /// - Parameter cornerRadius: radius (make very high for a circular indicator)
    public func cornerRadius(_ cornerRadius: CGFloat) -> PitchWheel {
        var copy = self
        copy.cornerRadius = cornerRadius
        return copy
    }

    /// Modifier to change the size of the indicator
    /// - Parameter indicatorHeight: preferred height
    public func indicatorHeight(_ indicatorHeight: CGFloat) -> PitchWheel {
        var copy = self
        copy.indicatorHeight = indicatorHeight
        return copy
    }
}

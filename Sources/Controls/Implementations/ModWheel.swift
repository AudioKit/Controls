import SwiftUI

/// Modulation wheel for a keyboard
public struct ModWheel: View {
    @Binding var location: Float

    var backgroundColor: Color = .gray
    var foregroundColor: Color = .red
    var cornerRadius: CGFloat = 0
    var indicatorPadding: CGFloat = 0.07
    var indicatorHeight: CGFloat = 40

    func maxOffset(_ geo: GeometryProxy) -> CGFloat {
        geo.size.height - indicatorHeight - 2 * indicatorPadding * geo.size.width
    }

    /// Initial the wheel with a type and bound value
    /// - Parameter value: value to control
    public init(value: Binding<Float>) {
        _location = value
    }

    public var body: some View {
        Control(value: $location,
                geometry: .verticalDrag(),
                padding: CGSize(width: 0, height: indicatorHeight / 2)) { geo in
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: cornerRadius).foregroundColor(backgroundColor)
                RoundedRectangle(cornerRadius: cornerRadius).foregroundColor(foregroundColor)
                    .frame(height: indicatorHeight)
                    .offset(y: -(maxOffset(geo) * CGFloat(location)))
                    .padding(indicatorPadding * geo.size.width)
            }.animation(.spring(response: 0.2), value: location)
        }
    }
}

extension ModWheel {
    internal init(location: Binding<Float>,
                  backgroundColor: Color,
                  foregroundColor: Color,
                  cornerRadius: CGFloat) {
        self._location = location
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.cornerRadius = cornerRadius
    }


    /// Modifer to change the background color of the wheel
    /// - Parameter backgroundColor: background color
    public func backgroundColor(_ backgroundColor: Color) -> ModWheel {
        return .init(location: _location,
                     backgroundColor: backgroundColor,
                     foregroundColor: foregroundColor,
                     cornerRadius: cornerRadius)
    }

    /// Modifer to change the foreground color of the wheel
    /// - Parameter foregroundColor: foreground color
    public func foregroundColor(_ foregroundColor: Color) -> ModWheel {
        return .init(location: _location,
                     backgroundColor: backgroundColor,
                     foregroundColor: foregroundColor,
                     cornerRadius: cornerRadius)
    }

    /// Modifer to change the corner radius of the wheel and the indicator
    /// - Parameter cornerRadius: radius (make very high for a circular indicator)
    public func cornerRadius(_ cornerRadius: CGFloat) -> ModWheel {
        return .init(location: _location,
                     backgroundColor: backgroundColor,
                     foregroundColor: foregroundColor,
                     cornerRadius: cornerRadius)
    }
}

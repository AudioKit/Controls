import SwiftUI

/// Horizontal slider bar
public struct Ribbon: View {
    @Binding var position: Float

    var backgroundColor: Color = .gray
    var foregroundColor: Color = .red
    var cornerRadius: CGFloat = 0
    var indicatorPadding: CGFloat = 0.07

    /// Initialize with the minimum description
    /// - Parameter position: Normalized position of the ribbon
    public init(position: Binding<Float>) {
        _position = position
    }

    func positionWidth(_ proxy: GeometryProxy) -> CGFloat {
        proxy.size.height * (1 - 2 * indicatorPadding)
    }

    public var body: some View {
        Control(value: $position, geometry: .horizontalPoint) { geo in
            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: cornerRadius).foregroundColor(backgroundColor)
                RoundedRectangle(cornerRadius: cornerRadius).foregroundColor(foregroundColor)
                    .squareFrame(positionWidth(geo))
                    .offset(x: CGFloat(position) * (geo.size.width - geo.size.height))
                    .padding(indicatorPadding * geo.size.height)
            }
        }
    }
}

extension Ribbon {
    internal init(position: Binding<Float>,
                  backgroundColor: Color,
                  foregroundColor: Color,
                  cornerRadius: CGFloat) {
        self._position = position
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.cornerRadius = cornerRadius
    }


    /// Modifer to change the background color of the ribbon
    /// - Parameter backgroundColor: background color
    public func backgroundColor(_ backgroundColor: Color) -> Ribbon {
        return .init(position: _position,
                     backgroundColor: backgroundColor,
                     foregroundColor: foregroundColor,
                     cornerRadius: cornerRadius)
    }

    /// Modifer to change the foreground color of the ribbon
    /// - Parameter foregroundColor: foreground color
    public func foregroundColor(_ foregroundColor: Color) -> Ribbon {
        return .init(position: _position,
                     backgroundColor: backgroundColor,
                     foregroundColor: foregroundColor,
                     cornerRadius: cornerRadius)
    }

    /// Modifer to change the corner radius of the ribbon bar and the indicator
    /// - Parameter cornerRadius: radius (make very high for a circular indicator)
    public func cornerRadius(_ cornerRadius: CGFloat) -> Ribbon {
        return .init(position: _position,
                     backgroundColor: backgroundColor,
                     foregroundColor: foregroundColor,
                     cornerRadius: cornerRadius)
    }
}

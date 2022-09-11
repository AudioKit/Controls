import SwiftUI

/// Horizontal slider bar
public struct Ribbon: View {
    @Binding var position: Float

    var backgroundColor: Color = .gray
    var foregroundColor: Color = .red
    var cornerRadius: CGFloat = 0
    var indicatorPadding: CGFloat = 0.07
    var indicatorWidth: CGFloat = 40

    /// Initialize with the minimum description
    /// - Parameter position: Normalized position of the ribbon
    public init(position: Binding<Float>) {
        _position = position
    }

    func maxOffset(_ geo: GeometryProxy) -> CGFloat {
        geo.size.width - indicatorWidth - 2 * indicatorPadding * geo.size.height
    }

    public var body: some View {
        Control(value: $position,
                geometry: .horizontalPoint,
                padding: CGSize(width: indicatorWidth / 2, height: 0)) { geo in
            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: cornerRadius).foregroundColor(backgroundColor)
                RoundedRectangle(cornerRadius: cornerRadius).foregroundColor(foregroundColor)
                    .frame(width: indicatorWidth)
                    .offset(x: CGFloat(position) * maxOffset(geo))
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

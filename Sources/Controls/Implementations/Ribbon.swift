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

    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius).foregroundColor(backgroundColor)
            Control(value: $position,
                    geometry: .horizontalPoint,
                    padding: CGSize(width: indicatorWidth / 2, height: 0)) { geo in
                Canvas { cx, size in
                    let viewport = CGRect(origin: .zero, size: size)
                    let indicatorRect = CGRect(origin: .zero,
                                               size: CGSize(width: indicatorWidth - geo.size.height * indicatorPadding * 2,
                                                            height: geo.size.height - geo.size.height * indicatorPadding * 2))

                    let activeWidth = viewport.size.width - indicatorRect.size.width

                    let offsetRect = indicatorRect
                        .offset(by: CGSize(width: activeWidth * ( CGFloat(position)),
                                           height: 0))
                    let cr = min(indicatorRect.height / 2, cornerRadius)
                    let ind = Path(roundedRect: offsetRect, cornerRadius: cr)

                    cx.fill(ind, with: .color(foregroundColor))
                }
                .padding(geo.size.height * indicatorPadding)
            }
        }
    }
}

extension Ribbon {
    /// Modifier to change the background color of the ribbon
    /// - Parameter backgroundColor: background color
    public func backgroundColor(_ backgroundColor: Color) -> Ribbon {
        var copy = self
        copy.backgroundColor = backgroundColor
        return copy
    }

    /// Modifier to change the foreground color of the ribbon
    /// - Parameter foregroundColor: foreground color
    public func foregroundColor(_ foregroundColor: Color) -> Ribbon {
        var copy = self
        copy.foregroundColor = foregroundColor
        return copy
    }

    /// Modifier to change the corner radius of the ribbon and the indicator
    /// - Parameter cornerRadius: radius (make very high for a circular indicator)
    public func cornerRadius(_ cornerRadius: CGFloat) -> Ribbon {
        var copy = self
        copy.cornerRadius = cornerRadius
        return copy
    }

    /// Modifier to change the size of the indicator
    /// - Parameter indicatorWidth: preferred width
    public func indicatorWidth(_ indicatorWidth: CGFloat) -> Ribbon {
        var copy = self
        copy.indicatorWidth = indicatorWidth
        return copy
    }
}

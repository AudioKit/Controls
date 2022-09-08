import SwiftUI

/// Horizontal slider bar
public struct Scrubber: View {
    @Binding var playhead: Float

    var backgroundColor: Color = .gray
    var foregroundColor: Color = .red
    var cornerRadius: CGFloat = 0
    var indicatorPadding: CGFloat = 0.07

    /// Initialize with the minimum description
    /// - Parameter playhead: Normalized position of the slider
    public init(playhead: Binding<Float>) {
        _playhead = playhead
    }

    func playheadWidth(_ proxy: GeometryProxy) -> CGFloat {
        proxy.size.height * (1 - 2 * indicatorPadding)
    }

    public var body: some View {
        Control(value: $playhead, geometry: .horizontalPoint) { geo in
            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: cornerRadius).foregroundColor(backgroundColor)
                RoundedRectangle(cornerRadius: cornerRadius).foregroundColor(foregroundColor)
                    .squareFrame(playheadWidth(geo))
                    .offset(x: CGFloat(playhead) * (geo.size.width - geo.size.height))
                    .padding(indicatorPadding * geo.size.height)
            }
        }
    }
}

extension Scrubber {
    internal init(playhead: Binding<Float>,
                  backgroundColor: Color,
                  foregroundColor: Color,
                  cornerRadius: CGFloat) {
        self._playhead = playhead
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.cornerRadius = cornerRadius
    }


    /// Modifer to change the background color of the slider
    /// - Parameter backgroundColor: background color
    public func backgroundColor(_ backgroundColor: Color) -> Scrubber {
        return .init(playhead: _playhead,
                     backgroundColor: backgroundColor,
                     foregroundColor: foregroundColor,
                     cornerRadius: cornerRadius)
    }

    /// Modifer to change the foreground color of the slider
    /// - Parameter foregroundColor: foreground color
    public func foregroundColor(_ foregroundColor: Color) -> Scrubber {
        return .init(playhead: _playhead,
                     backgroundColor: backgroundColor,
                     foregroundColor: foregroundColor,
                     cornerRadius: cornerRadius)
    }

    /// Modifer to change the corner radius of the slider bar and the indicator
    /// - Parameter cornerRadius: radius (make very high for a circular scrubber indicator)
    public func cornerRadius(_ cornerRadius: CGFloat) -> Scrubber {
        return .init(playhead: _playhead,
                     backgroundColor: backgroundColor,
                     foregroundColor: foregroundColor,
                     cornerRadius: cornerRadius)
    }
}

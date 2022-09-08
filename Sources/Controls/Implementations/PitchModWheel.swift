import SwiftUI

public enum WheelType {
    case pitch
    case mod
}

public struct PitchModWheel: View {
    var type: WheelType

    @Binding var location: Float

    var backgroundColor: Color = .gray
    var foregroundColor: Color = .red
    var cornerRadius: CGFloat = 0
    var indicatorPadding: CGFloat = 0.07

    func thumbHeight(_ geo: GeometryProxy) -> CGFloat {
        geo.size.width - 2 * indicatorPadding * geo.size.width
    }

    func maxOffset(_ geo: GeometryProxy) -> CGFloat {
        geo.size.height - geo.size.width
    }

    public init(type: WheelType, value: Binding<Float>) {
        self.type = type
        _location = value
    }

    public var body: some View {
        Control(value: $location,
                geometry: type == .mod ? .verticalDrag() : .verticalPoint,
                onEnded: { if type == .pitch { location = 0.5 } }) { geo in
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: cornerRadius).foregroundColor(backgroundColor)
                RoundedRectangle(cornerRadius: cornerRadius).foregroundColor(foregroundColor)
                    .frame(height: thumbHeight(geo))
                    .offset(y: -(maxOffset(geo) * CGFloat(location)))
                    .padding(indicatorPadding * geo.size.width)
            }.animation(.spring(response: 0.2), value: location)
        }.onAppear {
            if type == .pitch { location = 0.5 }
        }
    }
}

extension PitchModWheel {
    internal init(type: WheelType,
                  location: Binding<Float>,
                  backgroundColor: Color,
                  foregroundColor: Color,
                  cornerRadius: CGFloat) {
        self.type = type
        self._location = location
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.cornerRadius = cornerRadius
    }


    /// Modifer to change the background color of the slider
    /// - Parameter backgroundColor: background color
    public func backgroundColor(_ backgroundColor: Color) -> PitchModWheel {
        return .init(type: type,
                     location: _location,
                     backgroundColor: backgroundColor,
                     foregroundColor: foregroundColor,
                     cornerRadius: cornerRadius)
    }

    /// Modifer to change the foreground color of the slider
    /// - Parameter foregroundColor: foreground color
    public func foregroundColor(_ foregroundColor: Color) -> PitchModWheel {
        return .init(type: type,
                     location: _location,
                     backgroundColor: backgroundColor,
                     foregroundColor: foregroundColor,
                     cornerRadius: cornerRadius)
    }

    /// Modifer to change the corner radius of the slider bar and the indicator
    /// - Parameter cornerRadius: radius (make very high for a circular scrubber indicator)
    public func cornerRadius(_ cornerRadius: CGFloat) -> PitchModWheel {
        return .init(type: type,
                     location: _location,
                     backgroundColor: backgroundColor,
                     foregroundColor: foregroundColor,
                     cornerRadius: cornerRadius)
    }
}

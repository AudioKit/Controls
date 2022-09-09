import SwiftUI

/// XY control that doesn't snap
public struct XYPad: View {
    @Binding var x: Float
    @Binding var y: Float

    var backgroundColor: Color = .gray
    var foregroundColor: Color = .red
    var cornerRadius: CGFloat = 0
    var indicatorPadding: CGFloat = 0.07

    /// Initiale the control with two parameters
    /// - Parameters:
    ///   - x: horizontal parameter 0-1
    ///   - y: vertical parameter 0-1
    public init(x: Binding<Float>, y: Binding<Float>) {
        _x = x
        _y = y
    }

    func indicatorSize(_ proxy: GeometryProxy) -> CGFloat {
        max(proxy.size.width, proxy.size.height) / 10.0  * (1 - 2 * indicatorPadding)
    }

    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius).foregroundColor(backgroundColor)
            TwoParameterControl(value1: $x, value2: $y, geometry: .rectilinear) { geo in
                Canvas { cx, size in
                    let viewport = CGRect(origin: .zero, size: size)
                    let indicatorRect = CGRect(origin: .zero, size: CGSize(width: viewport.width / 10,
                                                                           height: viewport.height / 10))
                    let offsetRect = indicatorRect
                        .offset(by: CGSize(width: max(0,
                                                      min(viewport.size.width - indicatorRect.size.width,
                                                          CGFloat(x) * viewport.size.width - indicatorRect.width / 2)),
                                           height: max(0,
                                                       min(viewport.size.height - indicatorRect.height,
                                                       (1 - CGFloat(y)) * viewport.size.height - indicatorRect.height / 2))))
                    let cr = min(indicatorRect.height / 2, cornerRadius)
                    let ind = Path(roundedRect: offsetRect, cornerRadius: cr)

                    cx.fill(ind, with: .color(foregroundColor))

                }
            }.padding(10)
        }
    }
}

extension XYPad {
    internal init(x: Binding<Float>,
                  y: Binding<Float>,
                  backgroundColor: Color,
                  foregroundColor: Color,
                  cornerRadius: CGFloat) {
        self._x = x
        self._y = y
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.cornerRadius = cornerRadius
    }


    /// Modifer to change the background color of the xy pad
    /// - Parameter backgroundColor: background color
    public func backgroundColor(_ backgroundColor: Color) -> XYPad {
        return .init(x: _x, y: _y,
                     backgroundColor: backgroundColor,
                     foregroundColor: foregroundColor,
                     cornerRadius: cornerRadius)
    }

    /// Modifer to change the foreground color of the xy pad
    /// - Parameter foregroundColor: foreground color
    public func foregroundColor(_ foregroundColor: Color) -> XYPad {
        return .init(x: _x, y: _y,
                     backgroundColor: backgroundColor,
                     foregroundColor: foregroundColor,
                     cornerRadius: cornerRadius)
    }

    /// Modifer to change the corner radius of the xy pad and the indicator
    /// - Parameter cornerRadius: radius (make very high for a circular indicator)
    public func cornerRadius(_ cornerRadius: CGFloat) -> XYPad {
        return .init(x: _x, y: _y,
                     backgroundColor: backgroundColor,
                     foregroundColor: foregroundColor,
                     cornerRadius: cornerRadius)
    }
}

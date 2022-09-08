import SwiftUI

public struct Scrubber: View {
    @Binding var playhead: Float

    var backgroundColor: Color = .gray
    var foregroundColor: Color = .red
    var cornerRadius: CGFloat = 0

    public init(playhead: Binding<Float>) {
        _playhead = playhead
    }

    internal init(playhead: Binding<Float>,
                  backgroundColor: Color,
                  foregroundColor: Color,
                  cornerRadius: CGFloat) {
        self._playhead = playhead
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.cornerRadius = cornerRadius
        print(foregroundColor, backgroundColor)
    }


    public func backgroundColor(_ backgroundColor: Color) -> Scrubber {
        return .init(playhead: _playhead,
                     backgroundColor: backgroundColor,
                     foregroundColor: foregroundColor,
                     cornerRadius: cornerRadius)
    }

    public func foregroundColor(_ foregroundColor: Color) -> Scrubber {
        return .init(playhead: _playhead,
                     backgroundColor: backgroundColor,
                     foregroundColor: foregroundColor,
                     cornerRadius: cornerRadius)
    }

    public func cornerRadius(_ cornerRadius: CGFloat) -> Scrubber {
        return .init(playhead: _playhead,
                     backgroundColor: backgroundColor,
                     foregroundColor: foregroundColor,
                     cornerRadius: cornerRadius)
    }


    public var body: some View {
        Control(value: $playhead, geometry: .horizontalPoint) { geo in
            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: cornerRadius).foregroundColor(backgroundColor)
                RoundedRectangle(cornerRadius: cornerRadius).foregroundColor(foregroundColor)
                    .frame(width: geo.size.height, height: geo.size.height)
                    .offset(x: CGFloat(playhead) * geo.size.width * (1.0 - geo.size.height / geo.size.width))
            }.onAppear {
                print(geo.size)
            }
        }
    }
}

struct Scrubber_Previews: PreviewProvider {
    static var previews: some View {
        Scrubber(playhead: .constant(0.33))
    }
}

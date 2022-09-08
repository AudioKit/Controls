import SwiftUI

public struct Scrubber: View {
    @Binding var playhead: Float

    var playheadWidth: CGFloat
    var backgroundColor: Color = .gray
    var foregroundColor: Color = .red

    public init(playhead: Binding<Float>, playheadWidth: CGFloat = 0.1) {
        _playhead = playhead
        self.playheadWidth = playheadWidth
    }

    internal init(playhead: Binding<Float>,
                  playheadWidth: CGFloat,
                  backgroundColor: Color,
                  foregroundColor: Color) {
        self._playhead = playhead
        self.playheadWidth = playheadWidth
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }


    public func backgroundColor(_ newColor: Color) -> Scrubber {
        return .init(playhead: _playhead,
                     playheadWidth: playheadWidth,
                     backgroundColor: newColor,
                     foregroundColor: foregroundColor)
    }

    public func foregroundColor(_ newColor: Color) -> Scrubber {
        return .init(playhead: _playhead,
                     playheadWidth: playheadWidth,
                     backgroundColor: backgroundColor,
                     foregroundColor: newColor)
    }


    public var body: some View {
        Control(value: $playhead, geometry: .horizontalPoint) { geo in
            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: 10).foregroundColor(backgroundColor)
                RoundedRectangle(cornerRadius: 10).foregroundColor(foregroundColor)
                    .frame(width: geo.size.width * playheadWidth)
                    .offset(x: CGFloat(playhead) * geo.size.width * (1.0 - playheadWidth))
            }
        }
    }
}

struct Scrubber_Previews: PreviewProvider {
    static var previews: some View {
        Scrubber(playhead: .constant(0.33))
    }
}

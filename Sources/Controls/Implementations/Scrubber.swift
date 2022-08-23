import SwiftUI

public struct Scrubber: View {
    @Binding var playhead: Float

    public init(playhead: Binding<Float>) {
        _playhead = playhead
    }

    public var body: some View {
        Control(geometry: .horizontalPoint, value: $playhead) { geo in
            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: 10).foregroundColor(.gray)
                RoundedRectangle(cornerRadius: 10).foregroundColor(.red)
                    .frame(width: geo.size.width / 20)
                    .offset(x: CGFloat(playhead) * geo.size.width)
            }
        }
    }
}

struct Scrubber_Previews: PreviewProvider {
    static var previews: some View {
        Scrubber(playhead: .constant(0.33))
    }
}

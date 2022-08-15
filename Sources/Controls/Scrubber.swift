import SwiftUI

public struct Scrubber: View {
    @Binding var playhead: Double

    public init(playhead: Binding<Double>) {
        _playhead = playhead
    }

    public var body: some View {
        Draggable(geometry: .rectilinear, value: $playhead) { geo in
            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: 10).foregroundColor(.gray)
                RoundedRectangle(cornerRadius: 10).foregroundColor(.red)
                    .frame(width: geo.size.width / 20)
                    .offset(x: playhead * geo.size.width)
            }
        }
    }
}

struct Scrubber_Previews: PreviewProvider {
    static var previews: some View {
        Scrubber(playhead: .constant(0.33))
    }
}

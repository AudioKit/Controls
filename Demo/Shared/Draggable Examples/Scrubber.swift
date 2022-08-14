import DraggableControl
import SwiftUI

struct Scrubber: View {
    @State var playhead = 0.0

    var body: some View {
        Draggable(geometry: .rectilinear, value1: $playhead) { geo in
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
        Scrubber()
    }
}

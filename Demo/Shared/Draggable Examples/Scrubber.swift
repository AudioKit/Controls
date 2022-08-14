import DraggableControl
import SwiftUI

class ScrubberModel: ObservableObject {
    @Published var playhead = 0.0
}

struct Scrubber: View {
    @StateObject var model = ScrubberModel()

    var body: some View {
        Draggable(geometry: .rectilinear, value1: $model.playhead, value2: .constant(0)) { geo in
            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: 10).foregroundColor(.gray)
                RoundedRectangle(cornerRadius: 10).foregroundColor(.red)
                    .frame(width: geo.size.width / 20)
                    .offset(x: model.playhead * geo.size.width)
            }
        }
    }
}

struct Scrubber_Previews: PreviewProvider {
    static var previews: some View {
        Scrubber()
    }
}

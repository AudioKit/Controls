import SwiftUI
import DraggableControl

class ScrubberModel: ObservableObject {
    @Published var playhead = 0.0
}

struct Scrubber: View {

    @StateObject var model = ScrubberModel()

    var body: some View {
        GeometryReader { geo in
            Draggable(layout: .rectilinear, value1: $model.playhead, value2: .constant(0)) {
                ZStack(alignment: .bottomLeading) {
                    Rectangle().foregroundColor(.gray)
                    Rectangle().foregroundColor(.red)
                        .frame(width: geo.size.width / 20)
                        .offset(x: model.playhead * geo.size.width)
                }
            }
        }
    }
}


struct Scrubber_Previews: PreviewProvider {
    static var previews: some View {
        Scrubber()
    }
}

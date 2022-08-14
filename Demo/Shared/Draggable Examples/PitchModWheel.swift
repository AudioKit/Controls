import DraggableControl
import SwiftUI

class PitchWheelModel: ObservableObject {
    @Published var location = 0.0
}

enum WheelType {
    case pitch
    case mod
}

struct PitchModWheel: View {
    var type: WheelType

    @StateObject var model = PitchWheelModel()

    // XXX: the thumb height probably shouldn't be a
    //      function of the view's height.
    func thumbHeight(_ geo: GeometryProxy) -> CGFloat {
        geo.size.height / 20
    }

    func maxOffset(_ geo: GeometryProxy) -> CGFloat {
        geo.size.height - thumbHeight(geo)
    }

    var body: some View {
        return GeometryReader { geo in
            Draggable(geometry: type == .mod ? .relativeRectilinear() : .rectilinear,
                      value1: .constant(0),
                      value2: $model.location,
                      onEnded: { if type == .pitch { model.location = 0.5 } }) {
                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: 10).foregroundColor(.gray)
                    RoundedRectangle(cornerRadius: 10).foregroundColor(.red)
                        .frame(height: thumbHeight(geo))
                        .offset(y: -(maxOffset(geo) * model.location))
                }.animation(.spring(response: 0.2), value: model.location)
            }
        }.onAppear {
            if type == .pitch { model.location = 0.5 }
        }
    }
}

struct Fader_Previews: PreviewProvider {
    static var previews: some View {
        PitchModWheel(type: .pitch)
    }
}

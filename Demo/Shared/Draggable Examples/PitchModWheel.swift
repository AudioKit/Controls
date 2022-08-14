import DraggableControl
import SwiftUI

enum WheelType {
    case pitch
    case mod
}

struct PitchModWheel: View {
    var type: WheelType

    @State var location = 0.0

    // XXX: the thumb height probably shouldn't be a
    //      function of the view's height.
    func thumbHeight(_ geo: GeometryProxy) -> CGFloat {
        geo.size.height / 20
    }

    func maxOffset(_ geo: GeometryProxy) -> CGFloat {
        geo.size.height - thumbHeight(geo)
    }

    var body: some View {
        Draggable(geometry: type == .mod ? .relativeRectilinear() : .rectilinear,
                  value2: $location,
                  onEnded: { if type == .pitch { location = 0.5 } }) { geo in
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 10).foregroundColor(.gray)
                RoundedRectangle(cornerRadius: 10).foregroundColor(.red)
                    .frame(height: thumbHeight(geo))
                    .offset(y: -(maxOffset(geo) * location))
            }.animation(.spring(response: 0.2), value: location)
        }.onAppear {
            if type == .pitch { location = 0.5 }
        }
    }
}

struct Fader_Previews: PreviewProvider {
    static var previews: some View {
        PitchModWheel(type: .pitch)
    }
}

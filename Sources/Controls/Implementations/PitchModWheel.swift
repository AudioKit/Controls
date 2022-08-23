import SwiftUI

public enum WheelType {
    case pitch
    case mod
}

public struct PitchModWheel: View {
    var type: WheelType

    @Binding var location: Float

    // XXX: the thumb height probably shouldn't be a
    //      function of the view's height.
    func thumbHeight(_ geo: GeometryProxy) -> CGFloat {
        geo.size.height / 20
    }

    func maxOffset(_ geo: GeometryProxy) -> CGFloat {
        geo.size.height - thumbHeight(geo)
    }

    public init(type: WheelType, value: Binding<Float>) {
        self.type = type
        _location = value
    }

    public var body: some View {
        Control(geometry: type == .mod ? .relativeRectilinear() : .rectilinear,
                value: $location,
                onEnded: { if type == .pitch { location = 0.5 } }) { geo in
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 10).foregroundColor(.gray)
                RoundedRectangle(cornerRadius: 10).foregroundColor(.red)
                    .frame(height: thumbHeight(geo))
                    .offset(y: -(maxOffset(geo) * CGFloat(location)))
            }.animation(.spring(response: 0.2), value: location)
        }.onAppear {
            if type == .pitch { location = 0.5 }
        }
    }
}

struct Fader_Previews: PreviewProvider {
    static var previews: some View {
        PitchModWheel(type: .pitch, value: .constant(0.33))
    }
}

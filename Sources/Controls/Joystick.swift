import SwiftUI

public struct Joystick: View {
    @Binding var radius: Float
    @Binding var angle: Float

    func ended() { radius = 0 }

    public init(radius: Binding<Float>, angle: Binding<Float>) {
        _radius = radius
        _angle = angle
    }

    public var body: some View {
        Draggable(geometry: .polar(), value: $radius, value2: $angle, onEnded: ended) { geo in
            ZStack(alignment: .center) {
                Circle().foregroundColor(.gray)
                Circle().foregroundColor(.red)
                    .frame(width: geo.size.width / 10, height: geo.size.height / 10)
                    .offset(x: CGFloat(-radius * sin(angle * 2.0 * .pi)) * geo.size.width / 2.0,
                            y: CGFloat(radius * cos(angle * 2.0 * .pi)) * geo.size.height / 2.0)
                    .animation(.spring(response: 0.1), value: radius)
            }
        }
    }
}

struct Joystick_Previews: PreviewProvider {
    static var previews: some View {
        Joystick(radius: .constant(0.33), angle: .constant(0.33))
    }
}

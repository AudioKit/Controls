import DraggableControl
import SwiftUI

class JoystickModel: ObservableObject {
    @Published var radius = 0.0
    @Published var angle = 0.0
}

struct Joystick: View {
    @StateObject var model = JoystickModel()

    func ended() { model.radius = 0 }

    var body: some View {
        Draggable(geometry: .polar(), value1: $model.radius, value2: $model.angle, onEnded: ended) { geo in
            ZStack(alignment: .center) {
                Circle().foregroundColor(.gray)
                Circle().foregroundColor(.red)
                    .frame(width: geo.size.width / 10, height: geo.size.height / 10)
                    .offset(x: -model.radius * sin(model.angle * 2.0 * .pi) * geo.size.width / 2.0,
                            y: model.radius * cos(model.angle * 2.0 * .pi) * geo.size.height / 2.0)
                    .animation(.spring(response: 0.1), value: model.radius)
            }
        }
    }
}

struct Joystick_Previews: PreviewProvider {
    static var previews: some View {
        Joystick()
    }
}

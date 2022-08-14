import DraggableControl
import SwiftUI

class SimpleKnobModel: ObservableObject {
    @Published var volume = 0.0
}

struct SimpleKnob: View {
    @StateObject var model = ArcKnobModel()

    var body: some View {
        GeometryReader { geo in
            Draggable(geometry: .relativeRectilinear(ySensitivity: 2), value1: .constant(0), value2: $model.volume) {
                ZStack(alignment: .center) {
                    Ellipse().foregroundColor(.gray)
                    Rectangle().foregroundColor(.black)
                        .frame(width: geo.size.width / 20, height: geo.size.height / 4)
                        .rotationEffect(Angle(radians: model.volume * 1.6 * .pi + 0.2 * .pi))
                        .offset(x: -sin(model.volume * 1.6 * .pi + 0.2 * .pi) * geo.size.width / 2.0 * 0.75,
                                y: cos(model.volume * 1.6 * .pi + 0.2 * .pi) * geo.size.height / 2.0 * 0.75)
                }
            }
        }
    }
}

struct SimpleKnob_Previews: PreviewProvider {
    static var previews: some View {
        SimpleKnob()
    }
}

import Controls
import SwiftUI

struct SimpleKnob: View {
    @State var volume = 0.0

    var body: some View {
        Draggable(geometry: .relativeRectilinear(ySensitivity: 2),
                  value2: $volume) { geo in
            ZStack(alignment: .center) {
                Ellipse().foregroundColor(.gray)
                Rectangle().foregroundColor(.black)
                    .frame(width: geo.size.width / 20, height: geo.size.height / 4)
                    .rotationEffect(Angle(radians: volume * 1.6 * .pi + 0.2 * .pi))
                    .offset(x: -sin(volume * 1.6 * .pi + 0.2 * .pi) * geo.size.width / 2.0 * 0.75,
                            y: cos(volume * 1.6 * .pi + 0.2 * .pi) * geo.size.height / 2.0 * 0.75)
            }
        }
    }
}

struct SimpleKnob_Previews: PreviewProvider {
    static var previews: some View {
        SimpleKnob()
    }
}

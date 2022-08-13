import SwiftUI
import DraggableControl

struct ContentView: View {

    var body: some View {
        ZStack {
            Rectangle().foregroundColor(.white)

            HStack(spacing: 100) {
                VStack(spacing: 200) {
                    Draggable(layout: .rectilinear) { x, y in
                        Rectangle().foregroundColor(.red)
                            .offset(x: x * 100, y: -y * 100)
                    }
                    .frame(width: 100, height: 100)

                    Draggable(layout: .relativeRectilinear(xSensitivity: 0.1, ySensitivity: 0.1)) { x, y in
                        Rectangle().foregroundColor(.red)
                            .offset(x: x * 100, y: -y * 100)
                    }
                    .frame(width: 100, height: 100)


                    Draggable(layout: .polar) { r, theta in
                        Rectangle().foregroundColor(.green)
                            .rotationEffect(Angle(radians: theta * 2.0 * .pi))
                    }
                    .frame(width: 100, height: 100)

                }
            }
        }
    }
}

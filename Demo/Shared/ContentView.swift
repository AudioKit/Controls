import SwiftUI
import DraggableControl


struct ContentView: View {
    var body: some View {
        ZStack {
            Rectangle().foregroundColor(.white)
            XYPad().frame(width: 400, height: 400)
        }
    }
}

struct XYPad: View {

    let indicatorSize: CGFloat = 50
    var body: some View {
        GeometryReader { geo in
            Draggable(layout: .rectilinear) { x, y in
                ZStack(alignment: .bottomLeading) {
                    Rectangle().foregroundColor(.gray)
                    Circle().foregroundColor(.red)
                        .frame(width: indicatorSize, height: indicatorSize)
                        .offset(x: x * (geo.size.width - indicatorSize),
                                y: -y * (geo.size.height - indicatorSize))
                }
            }
        }
    }
}


struct TestingView: View {

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
                }
                VStack(spacing: 200) {
                    Draggable(layout: .relativePolar(radialSensitivity: 1)) { r, theta in
                        Rectangle().foregroundColor(.green)
                            .rotationEffect(Angle(radians: theta * 2.0 * .pi))
                            .scaleEffect(1.0 + r)
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

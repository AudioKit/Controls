import SwiftUI
import DraggableControl

struct ContentView: View {
    var body: some View {
        ZStack {
            Rectangle().foregroundColor(.white)
            VStack {
                HStack {
                    Spacer()
                    Fader().frame(width: 100)
                    Spacer()
                    VStack {
                        XYPad().frame(width: 400, height: 400)
                        Spacer()
                        Joystick().frame(width: 400, height: 400)
                    }
                    TestingView()
                }
                Spacer()
                Scrubber()
            }
        }
    }
}



struct TestingView: View {
    @State var x1: Double = 0
    @State var y1: Double = 0

    @State var x2: Double = 0
    @State var y2: Double = 0

    @State var r1: Double = 0
    @State var t1: Double = 0

    @State var r2: Double = 0
    @State var t2: Double = 0

    var body: some View {
        ZStack {
            Rectangle().foregroundColor(.white)

            HStack(spacing: 100) {
                VStack(spacing: 200) {
                    Draggable(layout: .rectilinear, value1: $x1, value2: $y1) {
                        Rectangle().foregroundColor(.red)
                            .offset(x: x1 * 100, y: -y1 * 100)
                    }
                    .frame(width: 100, height: 100)

                    Draggable(layout: .relativeRectilinear(xSensitivity: 0.1, ySensitivity: 0.1), value1: $x2, value2: $y2) {
                        Rectangle().foregroundColor(.red)
                            .offset(x: x2 * 100, y: -y2 * 100)
                    }
                    .frame(width: 100, height: 100)
                }
                VStack(spacing: 200) {
                    Draggable(layout: .relativePolar(radialSensitivity: 1), value1: $r1, value2: $t1) {
                        Rectangle().foregroundColor(.green)
                            .rotationEffect(Angle(radians: t1 * 2.0 * .pi))
                            .scaleEffect(1.0 + r1)
                    }
                    .frame(width: 100, height: 100)

                    Draggable(layout: .polar, value1: $r2, value2: $t2) {
                        Rectangle().foregroundColor(.green)
                            .rotationEffect(Angle(radians: t2 * 2.0 * .pi))
                    }
                    .frame(width: 100, height: 100)

                }
            }
        }
    }
}

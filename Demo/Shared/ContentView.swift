import SwiftUI
import DraggableControl

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Fader().frame(width: 100)
                Spacer()
                VStack {
                    XYPad().frame(width: 200, height: 200)
                    Spacer()
                    Joystick().frame(width: 200, height: 200)
                }
                Spacer()
                VStack(spacing: 100) {
                    SimpleKnob().frame(width: 200, height: 200)
                    ArcKnob().frame(width: 200, height: 200)
                    DualArcKnob().frame(width: 200, height: 200)
                }
                Spacer()
//                TestingView()
            }
            Spacer()
            Scrubber()
            IndexedSlider()

        }
    }
}



struct TestingView: View {

    @State var x: Double = 0
    @State var y: Double = 0

    @State var r: Double = 0
    @State var t: Double = 0

    var body: some View {
        ZStack {
            HStack(spacing: 100) {

                VStack(spacing: 200) {
                    Draggable(layout: .relativePolar(radialSensitivity: 1), value1: $r, value2: $t) {
                        Rectangle().foregroundColor(.green)
                            .rotationEffect(Angle(radians: t * 2.0 * .pi))
                            .scaleEffect(1.0 + r)
                    }
                    .frame(width: 100, height: 100)

                }
            }
        }
    }
}

import SwiftUI
import DraggableControl

struct ContentView: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 100) {
                Fader().frame(width: 100)
                VStack(spacing: 100) {
                    XYPad().frame(width: 200, height: 200)
                    Joystick().frame(width: 200, height: 200)
                }
                VStack(spacing: 100) {
                    SimpleKnob().frame(width: 200, height: 200)
                    ArcKnob().frame(width: 200, height: 200)
                    DualArcKnob().frame(width: 200, height: 200)
                }
            }
            Scrubber()
            IndexedSlider()
        }
    }
}




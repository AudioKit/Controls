import Controls
import SwiftUI

struct ContentView: View {
    @State var pitchBend: Float = 0.5
    @State var modulation: Float = 0

    @State var arcKnobValue: Float = 0.33
    @State var knobValue: Float = 0.33

    @State var x: Float = 0.5
    @State var y: Float = 0.5

    @State var radius: Float = 0
    @State var angle: Float = 0

    @State var volume: Float = 0.33
    @State var pan: Float = 0.33

    @State var playhead: Float = 0.33
    @State var index = 2

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 100) {
                HStack {
                    PitchModWheel(type: .pitch, value: $pitchBend)
                        .frame(width: 100)
                    PitchModWheel(type: .mod, value: $modulation)
                        .frame(width: 100)
                }
                VStack(spacing: 100) {
                    XYPad(x: $x, y: $y)
                        .frame(width: 200, height: 200)
                    Joystick(radius: $radius, angle: $angle)
                        .frame(width: 200, height: 200)
                }
                VStack(spacing: 100) {
                    SimpleKnob(value: $knobValue)
                        .frame(width: 200, height: 200)
                    ArcKnob(value: $arcKnobValue)
                        .frame(width: 200, height: 200)
                    DualArcKnob(volume: $volume, pan: $pan)
                        .frame(width: 200, height: 200)
                }
            }
            Scrubber(playhead: $playhead)
            IndexedSlider(index: $index, count: 5)
        }
    }
}

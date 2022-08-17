import Controls
import SwiftUI

struct ContentView: View {

    @State var pitchBend: Double = 0.5
    @State var modulation: Double = 0

    @State var arcKnobValue: Double = 0.33
    @State var knobValue: Double = 0.33

    @State var x: Double = 0.5
    @State var y: Double = 0.5

    @State var radius: Double = 0
    @State var angle: Double = 0

    @State var volume: Double = 0.33
    @State var pan: Double = 0.33

    @State var playhead: Double = 0.33
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

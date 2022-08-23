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

    @State var midiValue: Int = 0

    @State var playhead: Float = 0.33
    @State var index = 2

    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 10) {
                HStack(spacing: 10) {
                    HStack {
                        PitchModWheel(type: .pitch, value: $pitchBend)
                            .frame(width: proxy.size.width / 10)
                        PitchModWheel(type: .mod, value: $modulation)
                            .frame(width: proxy.size.width / 10)
                    }
                    VStack(spacing: 10) {
                        XYPad(x: $x, y: $y)
                        Joystick(radius: $radius, angle: $angle)
                    }
                    VStack(spacing: 10) {
                        SimpleKnob(value: $knobValue)
                        ArcKnob(value: $arcKnobValue)
                        MIDIKnob(value: $midiValue)
                    }
                }
                Scrubber(playhead: $playhead)
                    .frame(height: proxy.size.height / 10)
                IndexedSlider(index: $index, count: 5)
                    .frame(height: proxy.size.height / 10)
            }
        }
    }
}

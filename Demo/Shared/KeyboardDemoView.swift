import Controls
import Keyboard
import SwiftUI
import Tonic

struct KeyboardDemoView: View {

    @State var pitchBend: Float = 0.5
    @State var modulation: Float = 0
    @State var radius: Float = 0
    @State var angle: Float = 0
    @State var x: Float = 0.5
    @State var y: Float = 0.5
    
    @State var octaveRange = 0
    @State var layoutType = 0

    @State var filter: Float = 0.33
    @State var resonance: Float = 0.66
    @State var volume: Float = 0.8
    @State var pan: Float = 0

    var lowestNote = 48
    var hightestNote: Int {
        (octaveRange + 2) * 12 + lowestNote
    }

    var layout: KeyboardLayout {
        let pitchRange = Pitch(intValue: lowestNote)...Pitch(intValue: hightestNote)
        if layoutType == 0 {
            return .piano(pitchRange: pitchRange)
        } else if layoutType == 1 {
            return .isomorphic(pitchRange: pitchRange)
        } else {
            return .guitar()
        }
    }
    var body: some View {
        GeometryReader { proxy in
            HStack(spacing: 10) {
                VStack {
                    Spacer()
                    HStack {
                        Joystick(radius: $radius, angle: $angle)
                            .backgroundColor(.gray.opacity(0.5))
                            .foregroundColor(.white.opacity(0.5))
                            .squareFrame(140)
                        XYPad(x: $x, y: $y)
                            .backgroundColor(.gray.opacity(0.5))
                            .foregroundColor(.white.opacity(0.5))
                            .cornerRadius(20)
                            .squareFrame(140)
                        ArcKnob("FIL", value: $filter)
                            .backgroundColor(.gray.opacity(0.5))
                            .foregroundColor(.white.opacity(0.5))
                        ArcKnob("RES", value: $resonance)
                            .backgroundColor(.gray.opacity(0.5))
                            .foregroundColor(.white.opacity(0.5))
                        ArcKnob("PAN", value: $pan, range: -50...50)
                            .backgroundColor(.gray.opacity(0.5))
                            .foregroundColor(.white.opacity(0.5))
                        ArcKnob("VOL", value: $volume)
                            .backgroundColor(.gray.opacity(0.5))
                            .foregroundColor(.white.opacity(0.5))
                    }.frame(height: 140)
                    HStack {
                        Text("Octaves:")
                            .padding(.leading, 140)
                        IndexedSlider(index: $octaveRange, labels: ["2", "3", "4"])
                            .backgroundColor(.gray.opacity(0.5))
                            .foregroundColor(.white.opacity(0.5))
                            .cornerRadius(20)
                        Text("Layout:")
                            .padding(.leading, 140)
                        IndexedSlider(index: $layoutType, labels: ["Piano", "Isomorphic", "Guitar"])
                            .backgroundColor(.gray.opacity(0.5))
                            .foregroundColor(.white.opacity(0.5))
                            .cornerRadius(20)
                    }
                    .frame(height: 30)
                    HStack {
                        PitchModWheel(type: .pitch, value: $pitchBend)
                            .backgroundColor(.gray.opacity(0.5))
                            .foregroundColor(.white.opacity(0.5))
                            .cornerRadius(10)
                            .frame(width: 60)
                        PitchModWheel(type: .mod, value: $modulation)
                            .backgroundColor(.gray.opacity(0.5))
                            .foregroundColor(.white.opacity(0.5))
                            .cornerRadius(10)
                            .frame(width: 60)
                        Keyboard(layout: layout)
                    }
                }
            }
        }
    }
}


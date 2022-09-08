import Controls
import SwiftUI

struct ArcKnobDemoView: View {
    @State var volume: Float = 0.33
    @State var resonance: Float = 0.33
    @State var modulation: Float = 0.33

    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading, spacing: 40) {
                VStack(alignment: .center) {
                    ArcKnob("MOD", value: $modulation)
                        .backgroundColor(.yellow)
                        .foregroundColor(.blue)
                    ArcKnob("REZ", value: $resonance)
                        .backgroundColor(.orange)
                        .foregroundColor(.red)
                    ArcKnob("VOL", value: $volume)
                }
            }
        }
        .navigationTitle("Arc Knob")
        .toolbar { Text("") }
        .padding()
    }
}

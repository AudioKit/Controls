import Controls
import SwiftUI

struct ArcKnobDemoView: View {
    @State var volume: Float = 0.33
    @State var pan: Float = 0.33
    @State var dB: Float = 0

    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading, spacing: 40) {
                VStack(alignment: .center) {
                    ArcKnob("VOL", value: $volume)
                        .backgroundColor(.yellow)
                        .foregroundColor(.blue)
                    ArcKnob("dB", value: $dB, range: -20...6, origin: 0)
                        .backgroundColor(.orange)
                        .foregroundColor(.red)
                    ArcKnob("PAN", value: $pan, range: -50...50)
                        .foregroundColor(.accentColor)
                }
            }
        }
        .navigationTitle("Arc Knob")
        .padding()
    }
}

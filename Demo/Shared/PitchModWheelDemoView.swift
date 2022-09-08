import Controls
import SwiftUI

struct PitchModWheelDemoView: View {
    @State var pitchBend: Float = 0.5
    @State var modulation: Float = 0

    var body: some View {
        GeometryReader { proxy in
            HStack(spacing: 40) {
                PitchModWheel(type: .pitch, value: $pitchBend)
                    .frame(width: proxy.size.width / 10)
                PitchModWheel(type: .mod, value: $modulation)
                    .frame(width: proxy.size.width / 10)
            }
        }
        .navigationTitle("Pitch/Mod Wheel")
        .padding()
    }
}

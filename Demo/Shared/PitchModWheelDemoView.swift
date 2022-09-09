import Controls
import SwiftUI

struct PitchModWheelDemoView: View {
    @State var pitchBend: Float = 0.5
    @State var modulation: Float = 0

    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .center) {
                HStack(spacing: 20) {
                    Spacer()
                    PitchModWheel(type: .pitch, value: $pitchBend)
                        .backgroundColor(.yellow)
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                        .frame(width: proxy.size.width / 10)
                    PitchModWheel(type: .mod, value: $modulation)
                        .backgroundColor(.orange)
                        .foregroundColor(.red)
                        .cornerRadius(10)
                        .frame(width: proxy.size.width / 10)
                    Spacer()
                    PitchModWheel(type: .pitch, value: $pitchBend)
                        .foregroundColor(.black.opacity(0.5))
                        .cornerRadius(1000)
                        .frame(width: proxy.size.width / 10)
                    PitchModWheel(type: .mod, value: $modulation)
                        .foregroundColor(.white.opacity(0.5))
                        .frame(width: proxy.size.width / 10)
                    Spacer()
                }
            }
        }
        .navigationTitle("Pitch/Mod Wheel")
        .padding()
    }
}

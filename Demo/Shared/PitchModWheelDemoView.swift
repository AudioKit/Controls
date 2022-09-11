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
                    PitchWheel(value: $pitchBend)
                        .backgroundColor(.yellow)
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                        .frame(width: proxy.size.width / 10)
                    ModWheel(value: $modulation)
                        .backgroundColor(.orange)
                        .foregroundColor(.red)
                        .cornerRadius(10)
                        .frame(width: proxy.size.width / 10)
                    Spacer()
                    PitchWheel(value: $pitchBend)
                        .foregroundColor(.black.opacity(0.5))
                        .cornerRadius(10)
                        .indicatorHeight(100)
                        .frame(width: proxy.size.width / 10)
                    ModWheel(value: $modulation)
                        .foregroundColor(.white.opacity(0.5))
                        .indicatorHeight(100)
                        .frame(width: proxy.size.width / 10)
                    Spacer()
                }
            }
        }
        .navigationTitle("Pitch/Mod Wheel")
        .padding()
    }
}

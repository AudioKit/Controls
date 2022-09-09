import Controls
import PlaygroundSupport
import SwiftUI

struct ContentView: View {
    @State var volume: Float = 0.33
    @State var pan: Float = 0.33
    @State var dB: Float = 0

    @State var index = 0

    @State var radius: Float = 0
    @State var angle: Float = 0

    @State var x: Float = 0.5
    @State var y: Float = 0.5

    @State var pitchBend: Float = 0.5
    @State var modulation: Float = 0

    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .center) {
                HStack {
                    VStack {
                        ArcKnob("VOL", value: $volume)
                            .backgroundColor(.yellow)
                            .foregroundColor(.blue)
                        ArcKnob("dB", value: $dB, range: -20...6, origin: 0)
                            .backgroundColor(.orange)
                            .foregroundColor(.red)
                        ArcKnob("PAN", value: $pan, range: -50...50)
                            .foregroundColor(.accentColor)
                    }
                    VStack {
                        Joystick(radius: $radius, angle: $angle)
                            .backgroundColor(.yellow)
                            .foregroundColor(.blue)
                            .squareFrame(proxy.size.width / 4)
                        XYPad(x: $x, y: $y)
                            .backgroundColor(.orange)
                            .foregroundColor(.red)
                            .cornerRadius(10)
                            .squareFrame(proxy.size.height / 4)
                        HStack {
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
                        }
                    }
                }
                IndexedSlider(index: $index, labels: ["I", "ii", "iii", "IV", "V", "vi", "VII"])
                    .foregroundColor(.black.opacity(0.5))
                    .cornerRadius(1000)
                    .frame(height: proxy.size.height / 10)
            }
        }.frame(width: 600, height: 800)
    }
}


PlaygroundPage.current.setLiveView(ContentView())

import Controls
import SwiftUI

struct ScrubberDemoView: View {
    @State var playhead: Float = 0.33

    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading, spacing: 40) {
                Text("Similar to an Apple Horizontal Slider:")
                Text("but does not require starting on the handle")
                Slider(value: $playhead)
                Text("Customizable colors and corner radius")
                Group {
                    Scrubber(playhead: $playhead)
                        .frame(width: proxy.size.width / 3,
                               height: proxy.size.height / 80)
                    Scrubber(playhead: $playhead)
                        .frame(width: proxy.size.width / 2,
                               height: proxy.size.height / 40)
                    Scrubber(playhead: $playhead)
                        .backgroundColor(.yellow)
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                        .frame(height: proxy.size.height / 20)
                    Scrubber(playhead: $playhead)
                        .backgroundColor(.orange)
                        .foregroundColor(.red)
                        .cornerRadius(20)
                        .frame(height: proxy.size.height / 10)
                    Scrubber(playhead: $playhead)
                        .foregroundColor(.white.opacity(0.5))
                        .cornerRadius(1000)
                        .frame(height: proxy.size.height / 5)
                }
            }
        }
        .navigationTitle("Scrubber")
        .padding()
    }
}

struct ScrubberDemoView_Previews: PreviewProvider {
    static var previews: some View {
        ScrubberDemoView().previewDevice(.init("iPhone"))
    }
}
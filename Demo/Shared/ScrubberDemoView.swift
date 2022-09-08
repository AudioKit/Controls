import Controls
import SwiftUI

struct ScrubberDemoView: View {
    @State var playhead: Float = 0.33

    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading) {
                Text("Similar to an Apple Horizontal Slider")
                Text("Does not require starting on the handle")
                    .foregroundColor(.black)
                Spacer()
                Scrubber(playhead: $playhead)
                    .frame(
                        width: proxy.size.width / 8,
                        height: proxy.size.height / 80)
                Spacer()
                Text("Customizable colors")
                Scrubber(playhead: $playhead)
                    .backgroundColor(.yellow)
                    .foregroundColor(.blue)
                    .frame(height: proxy.size.height / 10)
                Spacer()
                Slider(value: $playhead) {
                    Text(playhead.description)
                }
                Spacer()
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

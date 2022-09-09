import Controls
import SwiftUI

struct RibbonDemoView: View {
    @State var position: Float = 0.33

    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading, spacing: 40) {
                Text("Similar to an Apple Horizontal Slider:")
                Text("but does not require starting on the handle")
                Slider(value: $position)
                Text("Customizable colors and corner radius")
                VStack(alignment: .center) {
                    Ribbon(position: $position)
                        .backgroundColor(.yellow)
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                        .frame(width: proxy.size.width / 3,
                               height: proxy.size.height / 20)
                    Ribbon(position: $position)
                        .backgroundColor(.orange)
                        .foregroundColor(.red)
                        .cornerRadius(20)
                        .frame(width: proxy.size.width / 2,
                               height: proxy.size.height / 10)
                    Ribbon(position: $position)
                        .foregroundColor(.white.opacity(0.5))
                        .cornerRadius(1000)
                        .frame(height: proxy.size.height / 10)
                }
            }
        }
        .navigationTitle("Ribbon")
        .padding()
    }
}

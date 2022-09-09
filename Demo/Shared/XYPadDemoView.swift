import Controls
import SwiftUI

struct XYPadDemoView: View {
    @State var x: Float = 0.5
    @State var y: Float = 0.5

    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading, spacing: 20) {
                Text("Controls two parameters in the x- and y-dimensions")
                Slider(value: $x)
                Slider(value: $y)
                Text("Customizable colors and corner radius")
                VStack(alignment: .center, spacing: 40) {
                    HStack(spacing: 40) {
                        XYPad(x: $x, y: $y)
                            .backgroundColor(.yellow)
                            .foregroundColor(.blue)
                            .cornerRadius(10)
                            .squareFrame(proxy.size.width / 4)
                        XYPad(x: $x, y: $y)
                            .backgroundColor(.orange)
                            .foregroundColor(.red)
                            .cornerRadius(10)
                            .squareFrame(proxy.size.height / 5)
                    }
                    HStack(spacing: 40) {
                        XYPad(x: $x, y: $y)
                            .foregroundColor(.white.opacity(0.5))
                            .cornerRadius(10)
                            .squareFrame(proxy.size.height / 3)
                        VStack{
                            XYPad(x: $x, y: $y)
                                .backgroundColor(.primary)
                                .foregroundColor(.accentColor)
                                .cornerRadius(20)
                                .squareFrame(proxy.size.height / 3)

                        }

                    }
                }
            }
        }
        .navigationTitle("XYPad")
        .padding()
    }
}

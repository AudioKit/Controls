import Controls
import SwiftUI

struct JoystickDemoView: View {
    @State var radius: Float = 0
    @State var angle: Float = 0

    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading, spacing: 20) {
                Text("Controls two parameters in the r- and theta-dimensions")
                Slider(value: $radius)
                Slider(value: $angle)
                Text("Customizable colors and corner radius")
                VStack(alignment: .center, spacing: 40) {
                    HStack(spacing: 40) {
                        Joystick(radius: $radius, angle: $angle)
                            .backgroundColor(.yellow)
                            .foregroundColor(.blue)
                            .squareFrame(proxy.size.width / 4)
                        Joystick(radius: $radius, angle: $angle)
                            .backgroundColor(.orange)
                            .foregroundColor(.red)
                            .squareFrame(proxy.size.height / 5)
                    }
                    HStack(spacing: 40) {
                        Joystick(radius: $radius, angle: $angle)
                            .foregroundColor(.white.opacity(0.5))
                            .cornerRadius(10)
                            .squareFrame(proxy.size.height / 3)
                        VStack{
                            Joystick(radius: $radius, angle: $angle)
                                .backgroundColor(.primary)
                                .foregroundColor(.accentColor)
                                .squareFrame(proxy.size.height / 3)

                        }

                    }
                }
            }
        }
        .navigationTitle("Joystick")
        .padding()
    }
}

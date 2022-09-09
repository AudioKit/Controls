import Controls
import SwiftUI

struct SmallKnobDemoView: View {
    @State var value: Float = 0.33

    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading, spacing: 40) {
                Text("This Knob allows you to start the touch point inside the knob")
                Text("and then change its value by both vertical and horizontal drag.")

                VStack(alignment: .center) {
                    SmallKnob(value: $value)
                        .backgroundColor(.yellow)
                        .foregroundColor(.blue)
                    SmallKnob(value: $value)
                        .backgroundColor(.orange)
                        .foregroundColor(.red)
                    SmallKnob(value: $value)
                }
            }
        }
        .navigationTitle("Simple Knob")
        .padding()
    }
}

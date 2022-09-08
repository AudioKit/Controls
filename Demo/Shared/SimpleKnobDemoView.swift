import Controls
import SwiftUI

struct SimpleKnobDemoView: View {
    @State var value: Float = 0.33

    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading, spacing: 40) {
                VStack(alignment: .center) {
                    SimpleKnob(value: $value)
                        .backgroundColor(.yellow)
                        .foregroundColor(.blue)
                    SimpleKnob(value: $value)
                        .backgroundColor(.orange)
                        .foregroundColor(.red)
                    SimpleKnob(value: $value)
                }
            }
        }
        .navigationTitle("Simple Knob")
        .toolbar { Text("") }
        .padding()
    }
}

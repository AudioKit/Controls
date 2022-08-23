import SwiftUI

public struct MIDIKnob: View {
    @Binding var value: Int
    var rangeDegrees = 270.0

    @State var normalizedValue: Float = 0

    public init(value: Binding<Int>) {
        _value = value
        normalizedValue = Float(value.wrappedValue) / 127.0
    }

    public var body: some View {
        Control(value: $normalizedValue, geometry: .twoDimensionalDrag()) { geo in
            ZStack(alignment: .center) {
                Circle()
                    .trim(from: 45.0 / 360.0, to: 315.0 / 360.0)
                    .rotation(.degrees(-rangeDegrees))
                    .stroke(Color.gray,
                            style: StrokeStyle(lineWidth: geo.size.width / 20,
                                               lineCap: .round))
                    .frame(width: geo.size.width * 0.8,
                           height: geo.size.height * 0.8)
                    .foregroundColor(.red)

                // Stroke value trim of knob
                Circle()
                    .trim(from: 45 / 360.0, to: (45 + Double(normalizedValue) * rangeDegrees) / 360.0)
                    .rotation(.degrees(-rangeDegrees))
                    .stroke(.red,
                            style: StrokeStyle(lineWidth: geo.size.width / 20,
                                               lineCap: .round))
                    .frame(width: geo.size.width * 0.8,
                           height: geo.size.height * 0.8)

                Text("\(Int(normalizedValue * 127))")
                    .frame(width: geo.size.width * 0.8)
                    .font(.largeTitle)
                    .foregroundColor(.gray)
            }
        }
        .onChange(of: normalizedValue) { newValue in
            value = Int(newValue * 127)
        }
    }
}

struct MIDIKnob_Previews: PreviewProvider {
    static var previews: some View {
        ArcKnob(value: .constant(0.33))
    }
}

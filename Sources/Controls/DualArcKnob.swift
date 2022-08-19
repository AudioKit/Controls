import SwiftUI

public struct DualArcKnob: View {
    @Binding var volume: Float
    @Binding var pan: Float
    var rangeDegrees = 270.0

    public init(volume: Binding<Float>, pan: Binding<Float>) {
        _volume = volume
        _pan = pan
    }

    public var body: some View {
        Draggable(geometry: .relativePolar(radialSensitivity: 2),
                  value: $volume,
                  value2: $pan) { geo in
            ZStack(alignment: .center) {
                Circle()
                    .trim(from: 45.0 / 360.0, to: 315.0 / 360.0)
                    .rotation(.degrees(-rangeDegrees))
                    .stroke(Color.gray, style: StrokeStyle(lineWidth: geo.size.width / 10, lineCap: .round))
                    .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.8)
                    .foregroundColor(.red)

                // Stroke value trim of knob
                Circle()
                    .trim(from: 45 / 360.0, to: (45 + Double(volume) * rangeDegrees) / 360.0)
                    .rotation(.degrees(-rangeDegrees))
                    .stroke(.red, style: StrokeStyle(lineWidth: geo.size.width / 10, lineCap: .round))
                    .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.8)

                Circle()
                    .trim(from: 45.0 / 360.0, to: 315.0 / 360.0)
                    .rotation(.degrees(-rangeDegrees))
                    .stroke(Color.gray, style: StrokeStyle(lineWidth: geo.size.width / 10, lineCap: .round))
                    .frame(width: geo.size.width * 0.5, height: geo.size.height * 0.5)
                    .foregroundColor(.red)

                // Stroke value trim of knob
                Circle()
                    .trim(from: 45 / 360.0, to: (45 + Double(pan) * rangeDegrees) / 360.0)
                    .rotation(.degrees(-rangeDegrees))
                    .stroke(.red, style: StrokeStyle(lineWidth: geo.size.width / 10, lineCap: .round))
                    .frame(width: geo.size.width * 0.5, height: geo.size.height * 0.5)
            }
        }
    }
}

struct DualArcKnob_Previews: PreviewProvider {
    static var previews: some View {
        DualArcKnob(volume: .constant(0.33), pan: .constant(0.33))
    }
}

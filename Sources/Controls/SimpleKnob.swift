import SwiftUI

public struct SimpleKnob: View {
    @Binding var volume: Double
    var range: ClosedRange<Double> = 0.0 ... 1.0

    public init(value: Binding<Double>, range: ClosedRange<Double> = 0.0 ... 1.0) {
        _volume = value
        self.range = range
    }

    var normalizedValue: Double {
        (volume - range.lowerBound) / (range.upperBound - range.lowerBound)
    }

    public var body: some View {
        Draggable(geometry: .relativeRectilinear(ySensitivity: 2),
                  value2: $volume, inRange2: range) { geo in
            ZStack(alignment: .center) {
                Ellipse().foregroundColor(.gray)
                Rectangle().foregroundColor(.black)
                    .frame(width: geo.size.width / 20, height: geo.size.height / 4)
                    .rotationEffect(Angle(radians: normalizedValue * 1.6 * .pi + 0.2 * .pi))
                    .offset(x: -sin(normalizedValue * 1.6 * .pi + 0.2 * .pi) * geo.size.width / 2.0 * 0.75,
                            y: cos(normalizedValue * 1.6 * .pi + 0.2 * .pi) * geo.size.height / 2.0 * 0.75)
            }
        }
        .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)

    }
}

struct SimpleKnob_Previews: PreviewProvider {
    static var previews: some View {
        SimpleKnob(value: .constant(0.33))
    }
}

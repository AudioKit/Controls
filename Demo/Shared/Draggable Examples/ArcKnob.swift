import DraggableControl
import SwiftUI

struct ArcKnob: View {
    @State var volume = 0.0
    var rangeDegrees = 270.0

    @State var isShowingValue = false

    var body: some View {
        Draggable(geometry: .polar(angularRange: Angle(degrees: 45) ... Angle(degrees: 315)),
                  value2: $volume,
                  onStarted: { isShowingValue = true },
                  onEnded: { isShowingValue = false }) { geo in
            ZStack(alignment: .center) {
                Circle()
                    .trim(from: 45.0 / 360.0, to: 315.0 / 360.0)
                    .rotation(.degrees(-rangeDegrees))
                    .stroke(Color.gray,
                            style: StrokeStyle(lineWidth: geo.size.width / 10,
                                               lineCap: .round))
                    .frame(width: geo.size.width * 0.8,
                           height: geo.size.height * 0.8)
                    .foregroundColor(.red)

                // Stroke value trim of knob
                Circle()
                    .trim(from: 45 / 360.0, to: (45 + volume * rangeDegrees) / 360.0)
                    .rotation(.degrees(-rangeDegrees))
                    .stroke(.red,
                            style: StrokeStyle(lineWidth: geo.size.width / 10,
                                               lineCap: .round))
                    .frame(width: geo.size.width * 0.8,
                           height: geo.size.height * 0.8)

                Text("\(isShowingValue ? String(format: "%0.2f", volume) : "VOL")")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                    .animation(.easeIn(duration: 2), value: isShowingValue)
            }
        }
    }
}

struct ArcKnob_Previews: PreviewProvider {
    static var previews: some View {
        ArcKnob()
    }
}

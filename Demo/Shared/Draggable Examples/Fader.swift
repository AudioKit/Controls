import SwiftUI
import DraggableControl

class FaderModel: ObservableObject {
    @Published var volume = 0.0
}

struct Fader: View {

    @StateObject var model = FaderModel()

    var body: some View {
        GeometryReader { geo in
            Draggable(layout: .rectilinear, value1: .constant(0), value2: $model.volume) {
                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: 10).foregroundColor(.gray)
                    RoundedRectangle(cornerRadius: 10).foregroundColor(.red)
                        .frame(height: geo.size.height / 20)
                        .offset(y: -model.volume * geo.size.height)
                }
            }
        }
    }
}


struct Fader_Previews: PreviewProvider {
    static var previews: some View {
        Fader()
    }
}

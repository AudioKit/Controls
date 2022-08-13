import SwiftUI
import DraggableControl

class XYPadModel: ObservableObject {
    @Published var x = 0.0
    @Published var y = 0.0
}

struct XYPad: View {

    @StateObject var model = XYPadModel()

    var body: some View {
        GeometryReader { geo in
            Draggable(layout: .rectilinear, value1: $model.x, value2: $model.y) {
                ZStack(alignment: .bottomLeading) {
                    Rectangle().foregroundColor(.gray)
                    Circle().foregroundColor(.red)
                        .frame(width: geo.size.width / 10, height: geo.size.height / 10)
                        .offset(x: model.x * (geo.size.width - geo.size.width / 10),
                                y: -model.y * (geo.size.height - geo.size.width / 10))
                }
            }
        }
    }
}


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        XYPad()
    }
}
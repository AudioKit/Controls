import DraggableControl
import SwiftUI

struct XYPad: View {
    @State var x = 0.0
    @State var y = 0.0
    
    var body: some View {
        Draggable(geometry: .rectilinear, value: $x, value2: $y) { geo in
            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: geo.size.width / 20).foregroundColor(.gray)
                Circle().foregroundColor(.red)
                    .frame(width: geo.size.width / 10, height: geo.size.height / 10)
                    .offset(x: x * (geo.size.width - geo.size.width / 10),
                            y: -y * (geo.size.height - geo.size.width / 10))
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        XYPad()
    }
}

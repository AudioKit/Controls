import SwiftUI
import DraggableControl

struct ContentView: View {

    var body: some View {
        ZStack {
            Rectangle().foregroundColor(.white)
            VStack {
                Spacer()
                Rectangle()
                    .foregroundColor(.black)
                    .draggable(layout: .rectilinear) { x, y in
                        print("x: \(x), y: \(y)")
                    }
                    .frame(width: 600, height: 200)
                Spacer()
                Circle()
                    .foregroundColor(.black)
                    .draggable(layout: .polar(anchor: .bottomLeading)) { r, theta in
                        print("r \(r), theta \(theta)")
                    }
                    .frame(width: 200, height: 200)
                Spacer()
            }
        }
    }
}

import SwiftUI
import DraggableControl

struct ContentView: View {
    var body: some View {
        ZStack {
            Rectangle().foregroundColor(.white)
            Rectangle()
                .foregroundColor(.black)
                .frame(width: 200, height: 200)
                .draggable { x, y in
                    print(x, y)
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

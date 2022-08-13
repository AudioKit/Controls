import SwiftUI
import DraggableControl

class IndexedSliderModel: ObservableObject {
    var indexCount: Int
    init(indexCount: Int) {
        self.indexCount = indexCount
    }
    @Published var index = 0.0

    @Published var normalValue = 0.0 {
        didSet {
            index = floor(normalValue * Double(indexCount)) / Double(indexCount)
        }
    }
}

struct IndexedSlider: View {

    @StateObject var model = IndexedSliderModel(indexCount: 5)

    var body: some View {
        GeometryReader { geo in
            Draggable(layout: .rectilinear, value1: $model.normalValue, value2: .constant(0)) {
                ZStack(alignment: .bottomLeading) {
                    Rectangle().foregroundColor(.gray)
                    Rectangle().foregroundColor(.red)
                        .frame(width: geo.size.width / CGFloat(model.indexCount))
                        .offset(x: model.index * geo.size.width)
                }
            }
        }
    }
}


struct IndexedSlider_Previews: PreviewProvider {
    static var previews: some View {
        IndexedSlider()
    }
}

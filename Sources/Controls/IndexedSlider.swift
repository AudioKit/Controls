import SwiftUI

class IndexedSliderModel: ObservableObject {
    var indexCount: Int
    init(indexCount: Int) {
        self.indexCount = indexCount
    }

    @Published var index = 0

    @Published var normalValue = 0.0 {
        didSet {
            index = Int(normalValue * Double(indexCount))
        }
    }
}

public struct IndexedSlider: View {
    @StateObject var model = IndexedSliderModel(indexCount: 5)

    public init() {}

    public var body: some View {
        Draggable(geometry: .rectilinear, value: $model.normalValue) { geo in
            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: 10).foregroundColor(.gray)
                ZStack {
                    RoundedRectangle(cornerRadius: 10).foregroundColor(.red)
                    Text("\(model.index + 1)").font(.largeTitle)
                }
                .frame(width: geo.size.width / CGFloat(model.indexCount))
                .offset(x: CGFloat(model.index) * geo.size.width / CGFloat(model.indexCount))
                .animation(.easeOut, value: model.index)
            }
        }
    }
}

struct IndexedSlider_Previews: PreviewProvider {
    static var previews: some View {
        IndexedSlider()
    }
}

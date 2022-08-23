import SwiftUI

public struct IndexedSlider: View {
    @Binding var index: Int
    @State var normalValue: Float = 0.0
    var count: Int

    public init(index: Binding<Int>, count: Int) {
        _index = index
        self.count = count
    }

    public var body: some View {
        Control(geometry: .horizontalPoint, value: $normalValue) { geo in
            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: 10).foregroundColor(.gray)
                ZStack {
                    RoundedRectangle(cornerRadius: 10).foregroundColor(.red)
                    Text("\(index + 1)").font(.largeTitle)
                }
                .frame(width: geo.size.width / CGFloat(count))
                .offset(x: CGFloat(index) * geo.size.width / CGFloat(count))
                .animation(.easeOut, value: index)
            }
        }.onChange(of: normalValue) { newValue in
            index = Int(newValue * Float(count))
        }
    }
}

struct IndexedSlider_Previews: PreviewProvider {
    static var previews: some View {
        IndexedSlider(index: .constant(2), count: 10)
    }
}

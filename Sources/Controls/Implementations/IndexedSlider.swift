import SwiftUI

public struct IndexedSlider: View {
    @Binding var index: Int
    @State var normalValue: Float = 0.0
    var labels: [String]

    public init(index: Binding<Int>, labels: [String]) {
        _index = index
        self.labels = labels
    }

    public var body: some View {
        Control(value: $normalValue, geometry: .horizontalPoint) { geo in
            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: 10).foregroundColor(.black.opacity(0.8))
                ZStack {
                    RoundedRectangle(cornerRadius: 10).foregroundColor(.white.opacity(0.2))
                    Text(labels[index])
                }.padding(2)
                .frame(width: geo.size.width / CGFloat(labels.count))
                .offset(x: CGFloat(index) * geo.size.width / CGFloat(labels.count))
                .animation(.easeOut, value: index)
            }
        }.onChange(of: normalValue) { newValue in
            index = Int(newValue * 0.99 * Float(labels.count))
        }
    }
}


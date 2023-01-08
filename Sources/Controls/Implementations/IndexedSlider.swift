import SwiftUI

public struct IndexedSlider: View {
    @Binding var index: Int
    @State var normalValue: Float = 0.0
    var labels: [String]

    var backgroundColor: Color = .gray
    var foregroundColor: Color = .red
    var cornerRadius: CGFloat = 0
    var indicatorPadding: CGFloat = 0.07

    public init(index: Binding<Int>, labels: [String]) {
        _index = index
        self.labels = labels
    }

    public var body: some View {
        Control(value: $normalValue, geometry: .horizontalPoint) { geo in
            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundColor(backgroundColor)
                ZStack {
                    ForEach(0..<labels.count, id: \.self) { i in
                        ZStack {
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .foregroundColor(foregroundColor.opacity(0.15))
                            Text(labels[i])
                        }.padding(indicatorPadding * geo.size.height)
                        .frame(width: geo.size.width / CGFloat(labels.count))
                        .offset(x: CGFloat(i) * geo.size.width / CGFloat(labels.count))
                    }
                }
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .foregroundColor(foregroundColor)
                    Text(labels[index])
                }.padding(indicatorPadding * geo.size.height)
                .frame(width: geo.size.width / CGFloat(labels.count))
                .offset(x: CGFloat(index) * geo.size.width / CGFloat(labels.count))
                .animation(.easeOut, value: index)
            }
        }.onChange(of: normalValue) { newValue in
            index = Int(newValue * 0.99 * Float(labels.count))
        }
    }
}

extension IndexedSlider {
    /// Modifier to change the background color of the slider
    /// - Parameter backgroundColor: background color
    public func backgroundColor(_ backgroundColor: Color) -> IndexedSlider {
        var copy = self
        copy.backgroundColor = backgroundColor
        return copy
    }

    /// Modifier to change the foreground color of the slider
    /// - Parameter foregroundColor: foreground color
    public func foregroundColor(_ foregroundColor: Color) -> IndexedSlider {
        var copy = self
        copy.foregroundColor = foregroundColor
        return copy
    }

    /// Modifier to change the corner radius of the slider bar and the indicator
    /// - Parameter cornerRadius: radius (make very high for a circular indicator)
    public func cornerRadius(_ cornerRadius: CGFloat) -> IndexedSlider {
        var copy = self
        copy.cornerRadius = cornerRadius
        return copy
    }
}

import SwiftUI

public struct Draggable<Content: View>: View {
    let content: () -> Content
    var layout: ControlLayout
    var ended: () -> Void
    @Binding var value1: Double
    @Binding var value2: Double

    @StateObject var model = DraggableModel()

    public init(layout: ControlLayout = .rectilinear,
                value1: Binding<Double>,
                value2: Binding<Double>,
                onEnded: @escaping () -> Void = {},
                @ViewBuilder content: @escaping () -> Content)
    {
        self.layout = layout
        self._value1 = value1
        self._value2 = value2
        self.ended = onEnded
        self.content = content
    }

    public var body: some View {
        DraggableContainer(model: model, ended: ended, content: content)
            .onPreferenceChange(TouchLocationKey.self) { touchLocation in
                model.touchLocation = touchLocation
            }
            .onPreferenceChange(RectKey.self) { rect in
                model.rect = rect
            }
            .onAppear {
                model.layout = layout
                model.value1 = _value1
                model.value2 = _value2
            }
    }
}

import SwiftUI

public struct Draggable<Content: View>: View {
    let content: (Double, Double) -> Content
    var layout: ControlLayout

    @StateObject var model: DraggableModel = .init()

    public init(layout: ControlLayout = .rectilinear,
                @ViewBuilder content: @escaping (Double, Double) -> Content)
    {
        self.layout = layout
        self.content = content
    }

    public var body: some View {
        DraggableContainer(model: model, content: content)
            .onPreferenceChange(TouchLocationKey.self) { touchLocation in
                model.touchLocation = touchLocation
            }
            .onPreferenceChange(RectKey.self) { rect in
                model.rect = rect
            }
            .onAppear {
                model.layout = layout
            }
    }
}

import SwiftUI

struct DraggableContainer<Content: View>: View {
    let content: () -> Content

    @ObservedObject var model: DraggableModel

    init(model: DraggableModel, @ViewBuilder content: @escaping ()  -> Content) {
        self.model = model
        self.content = content
    }

    @GestureState var touchLocation: CGPoint?

    func rect(rect: CGRect) -> some View {
        content()
            .contentShape(Rectangle()) // Added to improve tap/click reliability
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .updating($touchLocation) { value, state, _ in
                    state = value.location
                }
            )
            .preference(key: TouchLocationKey.self,
                        value: touchLocation != nil ? touchLocation! : .zero)
            .preference(key: RectKey.self, value: rect)
    }

    public var body: some View {
        GeometryReader { proxy in
            rect(rect: proxy.frame(in: .local))
        }
    }
}

import SwiftUI

struct DraggableContainer<Content: View>: View {
    let content: () -> Content
    let ended: () -> Void

    @ObservedObject var model: DraggableModel

    init(model: DraggableModel,
         ended: @escaping () -> Void = {},
         @ViewBuilder content: @escaping ()  -> Content)
    {
        self.model = model
        self.content = content
        self.ended = ended
    }

    @GestureState var touchLocation: CGPoint?

    func rect(rect: CGRect) -> some View {
        content()
            .contentShape(Rectangle()) // Added to improve tap/click reliability
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .updating($touchLocation) { value, state, _ in
                    state = value.location
                }
                .onEnded { _ in ended() }
            )
            .preference(key: TouchLocationKey.self,
                        value: touchLocation != nil ? touchLocation! : .zero)
            .preference(key: RectKey.self, value: rect)
    }

    var body: some View {
        GeometryReader { proxy in
            rect(rect: proxy.frame(in: .local))
        }
    }
}

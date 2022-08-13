import SwiftUI

struct DraggableContainer<Content: View>: View {
    let content: () -> Content
    let onStarted: () -> Void
    let onEnded: () -> Void

    @ObservedObject var model: DraggableModel

    init(model: DraggableModel,
         onStarted: @escaping () -> Void = {},
         onEnded: @escaping () -> Void = {},
         @ViewBuilder content: @escaping ()  -> Content)
    {
        self.model = model
        self.content = content
        self.onStarted = onStarted
        self.onEnded = onEnded
    }

    @GestureState var touchLocation: CGPoint?
    @State var hasStarted = false

    func rect(rect: CGRect) -> some View {
        content()
            .contentShape(Rectangle()) // Added to improve tap/click reliability
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .updating($touchLocation) { value, state, _ in
                    state = value.location
                }
                .onChanged { _ in if !hasStarted { onStarted() } }
                .onEnded { _ in onEnded(); hasStarted = false }
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

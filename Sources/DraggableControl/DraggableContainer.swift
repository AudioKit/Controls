import SwiftUI

struct DraggableContainer<Content: View>: View {
    let content: (Double, Double) -> Content

    @ObservedObject var model: DraggableModel

    init(model: DraggableModel,
         @ViewBuilder content: @escaping (Double, Double) -> Content)
    {
        self.model = model
        self.content = content
    }

    @GestureState var touchLocation: CGPoint?
    @GestureState var lastLocation: CGPoint?

    func rect(rect: CGRect) -> some View {
        content(model.value1, model.value2)
            .contentShape(Rectangle()) // Added to improve tap/click reliability
            .background(Color.gray.opacity(0.1))
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .updating($touchLocation) { value, state, _ in
                    if model.layout == .polar || model.layout == .rectilinear {
                        state = value.location
                    } else {
                        if let lastLocation = lastLocation {
                            model.value1 += (value.location.x - lastLocation.x) / model.rect.width
                            model.value2 -= (value.location.y - lastLocation.y) / model.rect.height
                        }
                    }
                }
                .updating($lastLocation) { value, state, _ in
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

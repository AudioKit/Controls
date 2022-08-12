import SwiftUI

public typealias TouchCallback = (Double, Double)-> Void

struct DraggableControl: ViewModifier {

    @GestureState var touchLocation: CGPoint?
    var layout: ControlLayout
    var callback: TouchCallback

    func body(content: Content) -> some View {
        GeometryReader { geo in
            content
                .gesture(DragGesture(minimumDistance: 0)
                    .updating($touchLocation) { value, state, _ in
                        state = value.location
                        switch layout {
                        case .rectilinear:
                            let nonDimensionalX = max(0.0, min(1.0, value.location.x / geo.size.width))
                            let nonDimensionalY = 1.0 - max(0.0, min(1.0, value.location.y / geo.size.height))
                            callback(nonDimensionalX, nonDimensionalY)

                        case .relativeRectilinear(xSensitivity: let xSensitivity, ySensitivity: let ySensitivity):
                            print(xSensitivity, ySensitivity)

                        case .polar(anchor: let anchor):
                            let frame = geo.frame(in: .local)
                            var center = CGPoint.zero
                            var deltaX = 0.0
                            var deltaY = 0.0
                            switch anchor {
                            case .topLeading:
                                center = CGPoint(x: frame.minX, y: frame.minY)
                                deltaX = (value.location.x - center.x) / (geo.size.width)
                                deltaY = (value.location.y - center.y) / (geo.size.height)
                            case .top:
                                center = CGPoint(x: frame.midX, y: frame.minY)
                                deltaX = (value.location.x - center.x) / (geo.size.width / 2.0)
                                deltaY = (value.location.y - center.y) / (geo.size.height)
                            case .topTrailing:
                                center = CGPoint(x: frame.maxX, y: frame.minY)
                                deltaX = (value.location.x - center.x) / (geo.size.width)
                                deltaY = (value.location.y - center.y) / (geo.size.height)

                            case .leading:
                                center = CGPoint(x: frame.minX, y: frame.midY)
                                deltaX = (value.location.x - center.x) / (geo.size.width)
                                deltaY = (value.location.y - center.y) / (geo.size.height / 2.0)

                            case .center:
                                center = CGPoint(x: frame.midX, y: frame.midY)
                                deltaX = (value.location.x - center.x) / (geo.size.width / 2.0)
                                deltaY = (value.location.y - center.y) / (geo.size.height / 2.0)
                            case .trailing:
                                center = CGPoint(x: frame.maxX, y: frame.midY)
                                deltaX = (value.location.x - center.x) / (geo.size.width)
                                deltaY = (value.location.y - center.y) / (geo.size.height / 2.0)

                            case .bottomLeading:
                                center = CGPoint(x: frame.minX, y: frame.maxY)
                                deltaX = (value.location.x - center.x) / (geo.size.width)
                                deltaY = (value.location.y - center.y) / (geo.size.height)
                            case .bottom:
                                center = CGPoint(x: frame.midX, y: frame.maxY)
                                deltaX = (value.location.x - center.x) / (geo.size.width / 2.0)
                                deltaY = (value.location.y - center.y) / (geo.size.height)

                            case .bottomTrailing:
                                center = CGPoint(x: frame.maxX, y: frame.maxY)
                                deltaX = (value.location.x - center.x) / (geo.size.width)
                                deltaY = (value.location.y - center.y) / (geo.size.height)
                            default:
                                print("using center")
                            }
                            var r = max(0.0, min(1.0, sqrt(deltaX * deltaX + deltaY * deltaY)))


                            var theta = 0.0
                            switch anchor {
                            case .topLeading:
                                theta = atan(deltaY / deltaX) / .pi * 2
                            case .top:
                                theta = atan(deltaY / deltaX) / .pi
                                if deltaX < 0 { theta += 1 }
                            case .topTrailing:
                                theta = atan(deltaY / deltaX) / .pi * 2 + 1.0
                            case .leading:
                                theta = atan(deltaY / deltaX) / .pi + 0.5
                            case .center:
                                theta = atan(deltaY / deltaX) / (2.0 * .pi) + 0.25
                                if deltaX > 0 { theta += 0.5 }
                            case .trailing:
                                theta = atan(deltaY / deltaX) / .pi + 0.5
                            case .bottomLeading:
                                theta = atan(deltaY / deltaX) / .pi * 2 + 1.0
                            case .bottom:
                                theta = atan(deltaY / deltaX) / .pi
                                if deltaX > 0 { theta += 1 }
                            case .bottomTrailing:
                                theta = atan(deltaY / deltaX) / .pi * 2
                            default:
                                print("using center")
                            }

                            theta = max(0.0, min(1.0, theta))
                            callback(r, theta)

                        case .relativePolar(anchor: let anchor, radialSensitivity: let radialSensitivity):
                            print(anchor, radialSensitivity)
                        }

                    }
                )
        }
    }
}

public extension View {
    func draggable(layout: ControlLayout, callback: @escaping TouchCallback) -> some View {
        modifier(DraggableControl(layout: layout, callback: callback))
    }
}

import SwiftUI

class DraggableModel: ObservableObject {
    @Published var value1: Double = 0.0
    @Published var value2: Double = 0.0

    var layout: ControlLayout = .rectilinear
    var rect: CGRect = .zero

    var touchLocation: CGPoint = .zero {
        didSet {
            guard touchLocation != oldValue,
                  touchLocation != .zero,
                  oldValue != .zero else { return }
            switch layout {
            case .rectilinear:
                print(touchLocation, rect)
                let nonDimensionalX = max(0.0, min(1.0, touchLocation.x / rect.size.width))
                let nonDimensionalY = 1.0 - max(0.0, min(1.0, touchLocation.y / rect.size.height))
                value1 = nonDimensionalX
                value2 = nonDimensionalY

            case .relativeRectilinear(xSensitivity: let xSensitivity, ySensitivity: let ySensitivity):
                let temp1 = value1 + (touchLocation.x - oldValue.x) * xSensitivity / rect.size.width
                let temp2 = value2 - (touchLocation.y - oldValue.y) * ySensitivity / rect.size.height

                value1 = max(0, min(1, temp1))
                value2 = max(0, min(1, temp2))
                print(value1, value2)

            case .polar:
                print(touchLocation, rect)
                let rTheta = calculateRadiusTheta(point: touchLocation,
                                                  frame: rect)
                value1 = rTheta.0
                value2 = rTheta.1

            case .relativePolar(radialSensitivity: let radialSensitivity):
                value1 = 0
                value2 = 0
            }
        }
    }

    func delta(point: CGPoint, frame: CGRect) -> CGPoint  {
        var center = CGPoint.zero

        var deltaX = 0.0
        var deltaY = 0.0

        center = CGPoint(x: frame.midX, y: frame.midY)
        deltaX = (point.x - center.x) / (frame.width / 2.0)
        deltaY = (point.y - center.y) / (frame.height / 2.0)

        return CGPoint(x: deltaX, y: deltaY)
    }

    func calculateRadiusTheta(point: CGPoint, frame: CGRect) -> (Double, Double) {

        let delta = delta(point: point, frame: frame)

        let r = max(0.0, min(1.0, sqrt(pow(delta.x, 2) + pow(delta.y, 2))))

        var theta = 0.0
        theta = atan(delta.y / delta.x) / (2.0 * .pi) + 0.25
        if delta.x > 0 { theta += 0.5 }

        theta = max(0.0, min(1.0, theta))

        return (r, theta)
    }
}

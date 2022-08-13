import SwiftUI

struct PolarCoordinate {
    var r: Double
    var theta: Angle
}

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
                value1 = max(0.0, min(1.0, touchLocation.x / rect.size.width))
                value2 = 1.0 - max(0.0, min(1.0, touchLocation.y / rect.size.height))

            case .relativeRectilinear(xSensitivity: let xSensitivity, ySensitivity: let ySensitivity):
                let temp1 = value1 + (touchLocation.x - oldValue.x) * xSensitivity / rect.size.width
                let temp2 = value2 - (touchLocation.y - oldValue.y) * ySensitivity / rect.size.height

                value1 = max(0, min(1, temp1))
                value2 = max(0, min(1, temp2))

            case .polar:
                let polar = polarCoordinate(point: touchLocation)
                value1 = polar.r
                value2 = max(0.0, min(1.0, polar.theta.radians / (2.0 * .pi)))

            case .relativePolar(radialSensitivity: let radialSensitivity):
                let oldPolar = polarCoordinate(point: oldValue)
                let newPolar = polarCoordinate(point: touchLocation)

                let temp1 = value1 + (newPolar.r - oldPolar.r) * radialSensitivity
                let temp2 = value2 + (newPolar.theta.radians - oldPolar.theta.radians) / (2.0 * .pi)

                value1 = max(0, min(1, temp1))
                value2 = max(0, min(1, temp2))
            }
        }
    }

    func polarCoordinate(point: CGPoint) -> PolarCoordinate {
        let deltaX = (point.x - rect.midX) / (rect.width / 2.0)
        let deltaY = (point.y - rect.midY) / (rect.height / 2.0)

        let r = max(0.0, min(1.0, sqrt(pow(deltaX, 2) + pow(deltaY, 2))))

        var theta = atan(deltaY / deltaX) + 0.5 * .pi
        if deltaX > 0 { theta += .pi }

        return PolarCoordinate(r: r, theta: Angle(radians: theta))
    }
}

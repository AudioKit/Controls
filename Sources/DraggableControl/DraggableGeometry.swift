import SwiftUI

/// Layouts define how the touch point's location affect the control values
public enum DraggableGeometry {
    /// Most sliders, both horizontal and vertical, where you expect
    /// your touch point to always represent the control point
    case rectilinear

    /// Knobs, or small control areas
    case relativeRectilinear(xSensitivity: Double = 1.0,
                             ySensitivity: Double = 1.0)

    /// Larger knobs with a more skeumorphic drag and twist motif.
    /// For non relative the values change immediately to match the touch.
    case polar(angularRange: ClosedRange<Angle> = Angle.zero ... Angle(degrees: 360))

    /// This version gives the user control in the radial direction
    /// and doesn't change the angle immediately to match the touch
    case relativePolar(radialSensitivity: Double = 1.0)
}

struct PolarCoordinate {
    var radius: Double
    var angle: Angle
}

extension Draggable {
    func calculateValuePairs(from oldValue: CGPoint) {
        guard touchLocation != .zero else { return }

        switch geometry {
        case .rectilinear:
            value1 = max(0.0, min(1.0, touchLocation.x / rect.size.width))
            value2 = 1.0 - max(0.0, min(1.0, touchLocation.y / rect.size.height))

        case let .relativeRectilinear(xSensitivity: xSensitivity, ySensitivity: ySensitivity):
            guard oldValue != .zero else { return }
            let temp1 = value1 + (touchLocation.x - oldValue.x) * xSensitivity / rect.size.width
            let temp2 = value2 - (touchLocation.y - oldValue.y) * ySensitivity / rect.size.height

            value1 = max(0, min(1, temp1))
            value2 = max(0, min(1, temp2))

        case let .polar(angularRange: angularRange):
            let polar = polarCoordinate(point: touchLocation)
            value1 = polar.radius
            let width = angularRange.upperBound.radians - angularRange.lowerBound.radians
            let value = (polar.angle.radians - angularRange.lowerBound.radians) / width
            value2 = max(0.0, min(1.0, value))

        case let .relativePolar(radialSensitivity: radialSensitivity):
            guard oldValue != .zero else { return }
            let oldPolar = polarCoordinate(point: oldValue)
            let newPolar = polarCoordinate(point: touchLocation)

            let temp1 = value1 + (newPolar.radius - oldPolar.radius) * radialSensitivity
            let temp2 = value2 + (newPolar.angle.radians - oldPolar.angle.radians) / (2.0 * .pi)

            value1 = max(0, min(1, temp1))
            value2 = max(0, min(1, temp2))
        }
    }

    func polarCoordinate(point: CGPoint) -> PolarCoordinate {
        // Calculate the x and y distances from the center
        let deltaX = (point.x - rect.midX) / (rect.width / 2.0)
        let deltaY = (point.y - rect.midY) / (rect.height / 2.0)

        // Convert to polar
        let radius = max(0.0, min(1.0, sqrt(pow(deltaX, 2) + pow(deltaY, 2))))
        var theta = atan(deltaY / deltaX)

        // Rotate to clockwise polar from -y axis (most like a knob)
        theta += .pi * (deltaX > 0 ? 1.5 : 0.5)

        return PolarCoordinate(radius: radius, angle: Angle(radians: theta))
    }
}

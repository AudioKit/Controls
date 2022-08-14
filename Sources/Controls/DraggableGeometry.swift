import SwiftUI

/// Geometry defines how the touch point's location affect the control values
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

        var temp1 = (value - range1.lowerBound) / (range1.upperBound - range1.lowerBound)
        var temp2 = (value2 - range2.lowerBound) / (range2.upperBound - range2.lowerBound)

        switch geometry {
        case .rectilinear:
            temp1 = touchLocation.x / rect.size.width
            temp2 = 1.0 - touchLocation.y / rect.size.height

        case let .relativeRectilinear(xSensitivity: xSensitivity, ySensitivity: ySensitivity):
            guard oldValue != .zero else { return }
            temp1 += (touchLocation.x - oldValue.x) * xSensitivity / rect.size.width
            temp2 -= (touchLocation.y - oldValue.y) * ySensitivity / rect.size.height

        case let .polar(angularRange: angularRange):
            let polar = polarCoordinate(point: touchLocation)
            let width = angularRange.upperBound.radians - angularRange.lowerBound.radians

            temp1 = polar.radius
            temp2 = (polar.angle.radians - angularRange.lowerBound.radians) / width

        case let .relativePolar(radialSensitivity: radialSensitivity):
            guard oldValue != .zero else { return }
            let oldPolar = polarCoordinate(point: oldValue)
            let newPolar = polarCoordinate(point: touchLocation)

            temp1 += (newPolar.radius - oldPolar.radius) * radialSensitivity
            temp2 += (newPolar.angle.radians - oldPolar.angle.radians) / (2.0 * .pi)

        }

        // Bound and convert to range
        value = max(0.0, min(1.0, temp1)) * (range1.upperBound - range1.lowerBound) + range1.lowerBound
        value2 = max(0.0, min(1.0, temp2)) * (range2.upperBound - range2.lowerBound) + range2.lowerBound
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

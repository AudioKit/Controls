import SwiftUI

/// Geometry defines how the touch point's location affect the control values
public enum PlanarGeometry {
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

    func calculateValuePair(value1: Float,
                            range1: ClosedRange<Float> = 0 ... 1,
                            value2: Float = 0,
                            range2: ClosedRange<Float> = 0 ... 1,
                            from oldValue: CGPoint,
                            to touchLocation: CGPoint,
                            inRect rect: CGRect,
                            padding: CGSize) -> (Float, Float)
    {
        guard touchLocation != .zero else { return (value1, value2) }

        var temp1 = (value1 - range1.lowerBound) / (range1.upperBound - range1.lowerBound)
        var temp2 = (value2 - range2.lowerBound) / (range2.upperBound - range2.lowerBound)

        let x = touchLocation.x - padding.width
        let y = touchLocation.y - padding.height

        switch self {
        case .rectilinear:
            temp1 = Float(x / (rect.size.width - 2 * padding.width))
            temp2 = Float(1.0 - y / (rect.size.height - 2 * padding.height))

        case let .relativeRectilinear(xSensitivity: xSensitivity, ySensitivity: ySensitivity):
            guard oldValue != .zero else { return (value1, value2) }
            temp1 += Float((touchLocation.x - oldValue.x) * xSensitivity / rect.size.width)
            temp2 -= Float((touchLocation.y - oldValue.y) * ySensitivity / rect.size.height)

        case let .polar(angularRange: angularRange):
            let polar = polarCoordinate(point: touchLocation, rect: rect)
            let width = angularRange.upperBound.radians - angularRange.lowerBound.radians
            temp1 = polar.radius
            temp2 = Float((polar.angle.radians - angularRange.lowerBound.radians) / width)

        case let .relativePolar(radialSensitivity: radialSensitivity):
            guard oldValue != .zero else { return (value1, value2) }
            let oldPolar = polarCoordinate(point: oldValue, rect: rect)
            let newPolar = polarCoordinate(point: touchLocation, rect: rect)

            temp1 += (newPolar.radius - oldPolar.radius) * Float(radialSensitivity)
            temp2 += Float((newPolar.angle.radians - oldPolar.angle.radians) / (2.0 * .pi))
        }

        // Bound and convert to range
        let newValue = max(0.0, min(1.0, temp1)) * (range1.upperBound - range1.lowerBound) + range1.lowerBound
        let newValue2 = max(0.0, min(1.0, temp2)) * (range2.upperBound - range2.lowerBound) + range2.lowerBound

        return (newValue, newValue2)
    }

    func polarCoordinate(point: CGPoint, rect: CGRect) -> PolarCoordinate {
        // Calculate the x and y distances from the center
        let deltaX = (point.x - rect.midX) / (rect.width / 2.0)
        let deltaY = (point.y - rect.midY) / (rect.height / 2.0)

        // Convert to polar
        let radius = max(0.0, min(1.0, sqrt(pow(deltaX, 2) + pow(deltaY, 2))))
        var theta = atan(deltaY / deltaX)

        // Rotate to clockwise polar from -y axis (most like a knob)
        theta += .pi * (deltaX > 0 ? 1.5 : 0.5)

        return PolarCoordinate(radius: Float(radius), angle: Angle(radians: theta))
    }
}

struct PolarCoordinate {
    var radius: Float
    var angle: Angle
}

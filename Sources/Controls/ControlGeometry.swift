import SwiftUI

/// Geometry defines how the touch point's location affect the control values
public enum ControlGeometry {
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

    func calculateValue(value: Float,
                        in range: ClosedRange<Float> = 0 ... 1,
                        from oldValue: CGPoint,
                        to touchLocation: CGPoint,
                        inRect rect: CGRect) -> Float
    {
        guard touchLocation != .zero else { return value }

        var temp = (value - range.lowerBound) / (range.upperBound - range.lowerBound)

        switch self {
        case .rectilinear:
            temp = Float(touchLocation.x / rect.size.width)

        case let .relativeRectilinear(xSensitivity: xSensitivity, ySensitivity: ySensitivity):
            guard oldValue != .zero else { return value }
            temp += Float((touchLocation.x - oldValue.x) * xSensitivity / rect.size.width)

        case let .polar(angularRange: angularRange):
            let polar = polarCoordinate(point: touchLocation, rect: rect)
            let width = angularRange.upperBound.radians - angularRange.lowerBound.radians

            temp = Float((polar.angle.radians - angularRange.lowerBound.radians) / width)

        case let .relativePolar(radialSensitivity: radialSensitivity):
            guard oldValue != .zero else { return value }
            let oldPolar = polarCoordinate(point: oldValue, rect: rect)
            let newPolar = polarCoordinate(point: touchLocation, rect: rect)

            temp += Float((newPolar.angle.radians - oldPolar.angle.radians) / (2.0 * .pi))
        }

        // Bound and convert to range
        let newValue = max(0.0, min(1.0, temp)) * (range.upperBound - range.lowerBound) + range.lowerBound

        return newValue
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

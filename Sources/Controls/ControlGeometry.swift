import SwiftUI

/// Geometry defines how the touch point's location affect the control values
public enum ControlGeometry {

    /// Horizontal slider controls in which you want the position to be exactly at the touch
    case horizontalPoint

    /// Vertical slider controls in which you want the position to be exactly at the touch
    case verticalPoint

    /// Knobs or controls that can start at any value and be changed with horizotal motion
    case horizontalDrag(xSensitivity: Double = 1.0)

    /// Knobs or controls that can start at any value and be changed with vertical motion
    case verticalDrag(ySensitivity: Double = 1.0)

    /// Controls that can change with either vertical or horizontal movement
    /// This is the type of knob used on AudioKit SynthOne
    case twoDimensionalDrag(xSensitivity: Double = 1.0, ySensitivity: Double = 1.0)

    /// Larger knobs that you want to rotate immediately to the touch point
    case angle(angularRange: ClosedRange<Angle> = Angle.zero ... Angle(degrees: 360))

    /// This allows the user to drag around the center
    case angularDrag(angularRange: ClosedRange<Angle> = Angle.zero ... Angle(degrees: 360))

    func calculateValue(value: Float,
                        in range: ClosedRange<Float> = 0 ... 1,
                        from oldValue: CGPoint,
                        to touchLocation: CGPoint,
                        inRect rect: CGRect) -> Float
    {
        guard touchLocation != .zero else { return value }

        var temp = (value - range.lowerBound) / (range.upperBound - range.lowerBound)

        switch self {

        case .horizontalPoint:
            temp = Float(touchLocation.x / rect.size.width)

        case .verticalPoint:
            temp = Float(1.0 - touchLocation.y / rect.size.height)

        case let .horizontalDrag(xSensitivity: xSensitivity):
            if oldValue != .zero {
                temp += Float((touchLocation.x - oldValue.x) * xSensitivity / rect.size.width)
            }

        case let .verticalDrag(ySensitivity: ySensitivity):
            if oldValue != .zero {
                temp -= Float((touchLocation.y - oldValue.y) * ySensitivity / rect.size.height)
            }

        case let .twoDimensionalDrag(xSensitivity: xSensitivity, ySensitivity: ySensitivity):
            if oldValue != .zero {
                temp += Float((touchLocation.x - oldValue.x) * xSensitivity / rect.size.width)
                temp -= Float((touchLocation.y - oldValue.y) * ySensitivity / rect.size.height)
            }
        case let .angle(angularRange: angularRange):
            let polar = polarCoordinate(point: touchLocation, rect: rect)
            let width = angularRange.upperBound.degrees - angularRange.lowerBound.degrees

            temp = Float((polar.angle.degrees - angularRange.lowerBound.degrees) / width)

        case .angularDrag(angularRange: _):
            if oldValue != .zero {
                let oldPolar = polarCoordinate(point: oldValue, rect: rect)
                let newPolar = polarCoordinate(point: touchLocation, rect: rect)
                temp += Float((newPolar.angle.radians - oldPolar.angle.radians) / (2.0 * .pi))
            }
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
        var theta = atan((point.y - rect.midY) / (point.x - rect.midX))

        // Rotate to clockwise polar from -y axis (most like a knob)
        theta += .pi * (deltaX > 0 ? 1.5 : 0.5)

        return PolarCoordinate(radius: Float(radius), angle: Angle(radians: theta))
    }
}

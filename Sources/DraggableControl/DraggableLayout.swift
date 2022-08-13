import SwiftUI

/// Layouts define how the touch point's location affect the control values
public enum DraggableLayout {
    /// Most sliders, both horizontal and vertical, where you expect
    /// your touch point to always represent the control point
    case rectilinear

    /// Knobs, or small control areas
    case relativeRectilinear(xSensitivity: Double = 1.0,
                             ySensitivity: Double = 1.0)

    /// Larger knobs with a more skeumorphic drag and twist motif.
    /// For non relative the values change immediately to match the touch.
    case polar(angularRange: ClosedRange<Angle> = Angle(radians: 0) ... Angle(radians: 2.0 * .pi))

    /// This version gives the user control in the radial direction
    /// and doesn't change the angle immediately to match the touch
    case relativePolar(radialSensitivity: Double = 1.0)
}

import Foundation
import SwiftUI

import SwiftUI

/// Layouts define how the touch point's location affect the control values
public enum ControlLayout {
    /// Most sliders, both horizontal and vertical, where you expect
    /// your touch point to be the represent control
    case rectilinear

    /// Knobs, or small control areas
    case relativeRectilinear(xSensitivity: Double = 1.0,
                             ySensitivity: Double = 1.0)

    /// Larger knobs with a more skeumorphic drag and twist motif.
    /// For non relative the values change immediately to match the touch.
    case polar

    /// This version gives the user more control in the radial direction
    /// and doesn't change immediately to match the touch
    case relativePolar(radialSensitivity: Double = 1.0)
}

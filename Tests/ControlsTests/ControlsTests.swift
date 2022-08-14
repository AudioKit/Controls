@testable import Controls
import XCTest

final class ControlsTests: XCTestCase {
    func testRectiLinear() throws {
        let geometry = DraggableGeometry.rectilinear

        var value = 0.0
        var value2 = 0.0

        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        (value, value2) = geometry.calculateValuePair(value: value,
                                                      in: 0...100,
                                                      value2: value2,
                                                      inRange2: -100...0,
                                                      from: CGPoint(x: rect.midX, y: rect.midY),
                                                      to: CGPoint(x: rect.maxX, y: rect.minY),
                                                      inRect: rect)


        XCTAssertEqual(value, 100)
        XCTAssertEqual(value2, 0)
    }
}

@testable import Controls
import XCTest

final class ControlsTests: XCTestCase {
    func testRectiLinear() throws {
        let geometry = PlanarGeometry.rectilinear

        var value1: Float = 0.0
        var value2: Float = 0.0

        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        (value1, value2) = geometry.calculateValuePair(value1: value1,
                                                      range1: 0 ... 100,
                                                      value2: value2,
                                                      range2: -100 ... 0,
                                                      from: CGPoint(x: rect.midX, y: rect.midY),
                                                      to: CGPoint(x: rect.maxX, y: rect.minY),
                                                      inRect: rect)

        XCTAssertEqual(value1, 100)
        XCTAssertEqual(value2, 0)
    }
}

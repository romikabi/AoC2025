import XCTest

@testable import AdventOfCode

final class Year2023Day06Tests: XCTestCase {
  private let data = """
    Time:      7  15   30
    Distance:  9  40  200
    """

  func testPart1() {
    let challenge = Year2023.Day06(data: data)
    XCTAssertEqual(String(describing: challenge.part1()), "288")
  }

  func testPart2() {
    let challenge = Year2023.Day06(data: data)
    XCTAssertEqual(String(describing: challenge.part2()), "71503")
  }
}

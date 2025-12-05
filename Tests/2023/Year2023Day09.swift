import XCTest

@testable import AdventOfCode

final class Year2023Day09Tests: XCTestCase {
  private let data = """
    0 3 6 9 12 15
    1 3 6 10 15 21
    10 13 16 21 30 45
    """

  func testPart1() {
    let challenge = Year2023.Day09(data: data)
    XCTAssertEqual(String(describing: challenge.part1()), "114")
  }

  func testPart2() {
    let challenge = Year2023.Day09(data: data)
    XCTAssertEqual(String(describing: challenge.part2()), "2")
  }
}

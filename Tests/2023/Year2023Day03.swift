import XCTest

@testable import AdventOfCode

final class Year2023Day03Tests: XCTestCase {
  private let data = """
    467..114..
    ...*......
    ..35..633.
    ......#...
    617*......
    .....+.58.
    ..592.....
    ......755.
    ...$.*....
    .664.598..
    """
  func testPart1() {
    let challenge = Year2023.Day03(data: data)
    XCTAssertEqual(String(describing: challenge.part1()), "4361")
  }

  func testPart2() {
    let challenge = Year2023.Day03(data: data)
    XCTAssertEqual(String(describing: challenge.part2()), "467835")
  }
}

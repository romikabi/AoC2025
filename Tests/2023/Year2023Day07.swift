import XCTest

@testable import AdventOfCode

final class Year2023Day07Tests: XCTestCase {
  private let data = """
    32T3K 765
    T55J5 684
    KK677 28
    KTJJT 220
    QQQJA 483
    """

  func testPart1() {
    let challenge = Year2023.Day07(data: data)
    XCTAssertEqual(String(describing: challenge.part1()), "6440")
  }

  func testPart2() {
    let challenge = Year2023.Day07(data: data)
    XCTAssertEqual(String(describing: challenge.part2()), "5905")
  }
}

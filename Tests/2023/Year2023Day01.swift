import XCTest

@testable import AdventOfCode

final class Year2023Day01Tests: XCTestCase {
  func testPart1() throws {
    let data = """
      1abc2
      pqr3stu8vwx
      a1b2c3d4e5f
      treb7uchet
      """
    let challenge = Year2023.Day01(data: data)
    XCTAssertEqual(String(describing: challenge.part1()), "142")
  }

  func testPart2() throws {
    let data = """
      two1nine
      eightwothree
      abcone2threexyz
      xtwone3four
      4nineeightseven2
      zoneight234
      7pqrstsixteen
      """
    let challenge = Year2023.Day01(data: data)
    XCTAssertEqual(String(describing: challenge.part2()), "281")
  }
}

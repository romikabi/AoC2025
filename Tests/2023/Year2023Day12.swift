import XCTest

@testable import AdventOfCode

final class Year2023Day12Tests: XCTestCase {
  private let data = """
    ???.### 1,1,3
    .??..??...?##. 1,1,3
    ?#?#?#?#?#?#?#? 1,3,1,6
    ????.#...#... 4,1,1
    ????.######..#####. 1,6,5
    ?###???????? 3,2,1
    """

  func testPart1() {
    let challenge = Year2023.Day12(data: data)
    XCTAssertEqual(String(describing: challenge.part1()), "21")
  }

  func testPart2() {
    let challenge = Year2023.Day12(data: data)
    XCTAssertEqual(String(describing: challenge.part2()), "525152")
  }
}

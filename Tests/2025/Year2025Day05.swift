import Testing

@testable import AdventOfCode

struct Year2025Day05Tests {
  let testData = """
    3-5
    10-14
    16-20
    12-18

    1
    5
    8
    11
    17
    32
    """

  @Test func testPart1() async throws {
    let challenge = Year2025.Day05(data: testData)
    #expect(String(describing: challenge.part1()) == "3")
  }

  @Test func testPart2() async throws {
    let challenge = Year2025.Day05(data: testData)
    #expect(String(describing: challenge.part2()) == "14")
  }
}

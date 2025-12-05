import Testing

@testable import AdventOfCode

struct Year2025Day04Tests {
  let testData = """
    ..@@.@@@@.
    @@@.@.@.@@
    @@@@@.@.@@
    @.@@@@..@.
    @@.@@@@.@@
    .@@@@@@@.@
    .@.@.@.@@@
    @.@@@.@@@@
    .@@@@@@@@.
    @.@.@@@.@.
    """

  @Test func testPart1() async throws {
    let challenge = Year2025.Day04(data: testData)
    #expect(String(describing: challenge.part1()) == "13")
  }

  @Test func testPart2() async throws {
    let challenge = Year2025.Day04(data: testData)
    #expect(String(describing: challenge.part2()) == "43")
  }
}

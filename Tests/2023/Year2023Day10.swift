import XCTest

@testable import AdventOfCode

final class Year2023Day10Tests: XCTestCase {
  func testPart1() {
    let data = """
      ..F7.
      .FJ|.
      SJ.L7
      |F--J
      LJ...
      """
    let challenge = Year2023.Day10(data: data)
    XCTAssertEqual(String(describing: challenge.part1()), "8")
  }

  func testPart2() {
    let data = """
      FF7FSF7F7F7F7F7F---7
      L|LJ||||||||||||F--J
      FL-7LJLJ||||||LJL-77
      F--JF--7||LJLJ7F7FJ-
      L---JF-JLJ.||-FJLJJ7
      |F|F-JF---7F7-L7L|7|
      |FFJF7L7F-JF7|JL---7
      7-L-JL7||F7|L7F-7F7|
      L.L7LFJ|||||FJL7||LJ
      L7JLJL-JLJLJL--JLJ.L
      """
    let challenge = Year2023.Day10(data: data)
    XCTAssertEqual(String(describing: challenge.part2()), "10")
  }
}

//┌┌┐┌S┌┐┌┐┌┐┌┐┌┐┌───┐
//└│└┘││││││││││││┌──┘
//┌└─┐└┘└┘││││││└┘└─┐┐
//┌──┘┌──┐││└┘└┘I┌┐┌┘─
//└───┘┌─┘└┘IIII┌┘└┘┘┐
//│┌│┌─┘┌───┐III└┐└│┐│
//│┌┌┘┌┐└┐┌─┘┌┐II└───┐
//┐─└─┘└┐││┌┐│└┐┌─┐┌┐│
//└.└┐└┌┘│││││┌┘└┐││└┘
//└┐┘└┘└─┘└┘└┘└──┘└┘.└

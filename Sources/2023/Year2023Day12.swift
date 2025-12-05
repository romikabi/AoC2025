import Core

extension Year2023 {
  final class Day12 {
    private let data: String

    init(data: String) {
      self.data = data
    }
  }
}

extension Year2023.Day12: AdventDay {
  func part1() -> Any {
    var solver = Solver(data: data)
    return solver.part1()
  }

  func part2() -> Any {
    var solver = Solver(data: data)
    return solver.part2()
  }
}

private struct Solver {
  private var cache: [Key: Int] = [:]
  private let data: String

  init(data: String) {
    self.data = data
  }

  mutating func part1() -> Any {
    data
      .split(separator: "\n")
      .map { line in
        let parts = line.split(separator: " ")
        return solve(
          springs: parts.first ?? "",
          broken: ArraySlice(parts.last?.split(separator: ",").compactMap { Int($0) } ?? [])
        )
      }
      .reduce(0, +)
  }

  mutating func part2() -> Any {
    data
      .split(separator: "\n")
      .map { line in
        let parts = line.split(separator: " ")
        return solve(
          springs: Array(repeating: parts.first ?? "", count: 5).joined(separator: "?")[...],
          broken: ArraySlice(
            Array(repeating: parts.last ?? "", count: 5).joined(separator: ",").split(
              separator: ","
            ).compactMap { Int($0) })
        )
      }
      .reduce(0, +)
  }

  private mutating func solve(springs: Substring, broken: ArraySlice<Int>) -> Int {
    let key = Key(springs: String(springs), broken: Array(broken))
    if let result = cache[key] {
      return result
    }
    let solution = rawSolve(springs: springs, broken: broken)
    cache[key] = solution
    return solution
  }

  private mutating func rawSolve(springs: Substring, broken: ArraySlice<Int>) -> Int {
    switch springs.first {
    case "#":
      guard let row = broken.first,
        !springs.prefix(row).contains("."),
        springs.count == row
          || springs.count > row && springs[springs.index(springs.startIndex, offsetBy: row)] != "#"
      else {
        return 0
      }
      return solve(springs: springs.dropFirst(row + 1), broken: broken.dropFirst())

    case "?":
      return solve(springs: "#" + springs.dropFirst(), broken: broken)
        + solve(springs: "." + springs.dropFirst(), broken: broken)
    case nil:
      return broken.isEmpty ? 1 : 0
    default:
      return solve(springs: springs.drop { $0 == "." }, broken: broken)
    }
  }

  private struct Key: Hashable {
    let springs: String
    let broken: [Int]
  }
}

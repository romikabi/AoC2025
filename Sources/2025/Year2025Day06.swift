import Core
import Foundation

extension Year2025 {
  struct Day06 {
    private let data: String

    init(data: String) {
      self.data = data
    }
  }
}

extension Year2025.Day06: AdventDay {
  func part1() -> Int {
    let splitted =
      data
      .split(separator: "\n")
      .map { $0.split(separator: /\s+/).map(String.init) }
    let columns = splitted.first?.count ?? 0
    let signs = splitted.indices.last ?? 0
    let problems = (0..<columns).map { column in
      Problem(
        numbers: splitted.indices.dropLast().compactMap { row in
          Int(splitted[row][column])
        },
        op: splitted[signs][column] == "+" ? (+) : (*)
      )
    }
    return problems.map(\.solution).reduce(0, +)
  }

  func part2() -> Int {
    let rows = data.split(separator: "\n").map { row in
      row.map(Character.init)
    }

    var problems: [Problem] = []
    var numbers: [Int] = []
    var op: @Sendable (Int, Int) -> Int = (+)
    for c in rows.first!.indices {
      if rows.allSatisfy({ c >= $0.count || $0[c] == " " }) {
        problems.append(
          Problem(
            numbers: numbers,
            op: op
          ))
        numbers = []
      } else {
        let string = String(rows.dropLast().map { c < $0.count ? $0[c] : " " }).trimmingCharacters(
          in: .whitespaces)
        numbers.append(Int(string) ?? 0)
        switch rows.last![c] {
        case "+":
          op = (+)
        case "*":
          op = (*)
        default:
          break
        }
      }
    }

    if !numbers.isEmpty {
      problems.append(
        Problem(
          numbers: numbers,
          op: op
        ))
      numbers = []
    }

    return problems.map(\.solution).reduce(0, +)
  }
}

private struct Problem: Sendable {
  let numbers: [Int]
  let op: @Sendable (Int, Int) -> Int

  var solution: Int {
    guard let first = numbers.first else { return 0 }
    return numbers.dropFirst().reduce(first, op)
  }
}

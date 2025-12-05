import Core

extension Year2023 {
  struct Day13 {
    private let data: String

    init(data: String) {
      self.data = data
    }
  }
}

extension Year2023.Day13: AdventDay {
  func part1() -> Any {
    calculate(smudges: 0)
  }

  func part2() -> Any {
    calculate(smudges: 1)
  }

  private func calculate(smudges: Int) -> Int {
    data.split(separator: "\n\n")
      .map { calculate($0, smudges: smudges) }
      .reduce(0, +)
  }

  private func calculate(_ pattern: Substring, smudges: Int) -> Int {
    let rows = pattern.split(separator: "\n").map(Array.init)
    let columns = rows[0].indices.map { index in
      rows.map { $0[index] }
    }

    let vertical = calculate(columns, smudges: smudges)
    let horizontal = calculate(rows, smudges: smudges)

    return vertical + horizontal * 100
  }

  private func calculate(_ array: [[Character]], smudges: Int) -> Int {
    array.indices.dropFirst().lazy.firstNonNil { index in
      calculate(array, mirror: index, smudges: smudges)
    } ?? 0
  }

  private func calculate(_ array: [[Character]], mirror: Int, smudges: Int) -> Int? {
    var l = mirror - 1
    var r = mirror
    var smudges = smudges
    while l >= 0, r < array.count {
      guard array[l].equals(array[r], smudges: &smudges) else { return nil }
      l -= 1
      r += 1
    }
    guard smudges == 0 else { return nil }
    return mirror
  }
}

extension Array where Element: Equatable {
  fileprivate func equals(_ rhs: Self, smudges: inout Int) -> Bool {
    let lhs = self
    guard lhs.count == rhs.count else { return false }
    for (lhs, rhs) in zip(lhs, rhs) where lhs != rhs {
      guard smudges > 0 else { return false }
      smudges -= 1
    }
    return true
  }
}

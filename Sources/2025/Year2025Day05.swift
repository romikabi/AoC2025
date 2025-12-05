import Core
import Foundation

extension Year2025 {
  struct Day05 {
    private let ranges: [Range<Int>]
    private let ingredients: [Int]
  }
}

extension Year2025.Day05: AdventDay {
  init(data: String) {
    let parts = data.split(separator: "\n\n")
    ranges = parts[0].split(separator: "\n").compactMap { line -> Range<Int>? in
      let numbers = line.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: "-")
      guard numbers.count == 2,
        let first = Int(numbers[0]),
        let second = Int(numbers[1]),
        first <= second
      else {
        print("dropped <\(line)>")
        return nil
      }
      return first..<(second + 1)
    }
    ingredients = parts[1].split(separator: "\n").compactMap { Int($0) }
  }

  func part1() -> Int {
    ingredients.reduce(into: 0) { sum, ingredient in
      for range in ranges where range.contains(ingredient) {
        sum += 1
        break
      }
    }
  }

  func part2() -> Int {
    ranges.reduce(into: RangeSet()) { set, range in
      set.insert(contentsOf: range)
    }.ranges.map(\.count).reduce(0, +)
  }
}

import Core
import Foundation

extension Year2023 {
  struct Day08 {
    private let data: String

    init(data: String) {
      self.data = data
    }
  }
}

extension Year2023.Day08: AdventDay {
  func part1() -> Any {
    let (sequence, map) = parse(data)
    var index = sequence.startIndex
    var place = Substring("AAA")
    var steps = 0
    while place != "ZZZ" {
      steps += 1
      let map = map[place]!
      let next: Substring
      if sequence[index] == "R" {
        next = map.right
      } else {
        next = map.left
      }
      place = next
      index = sequence.index(after: index)
      if index == sequence.endIndex {
        index = sequence.startIndex
      }
    }

    return steps
  }

  func part2() -> Any {
    let (sequence, map) = parse(data)
    let starts = map.keys.filter { $0.last == "A" }
    let steps = starts.map { start in
      var steps = 0
      var place = start
      var index = sequence.startIndex
      while place.last != "Z" {
        steps += 1
        let map = map[place]!
        let next: Substring
        if sequence[index] == "R" {
          next = map.right
        } else {
          next = map.left
        }
        place = next
        index = sequence.index(after: index)
        if index == sequence.endIndex {
          index = sequence.startIndex
        }
      }
      return steps
    }

    return steps.lcm
  }
}

private func parse(
  _ data: String
) -> (sequence: Substring, map: [Substring: (left: Substring, right: Substring)]) {
  let lines = data.split(separator: "\n")
  let sequence = lines.first ?? .init()
  let regex = /(?<key>\w+) = \((?<left>\w+), (?<right>\w+)\)/
  let parsed = lines.dropFirst().compactMap { line in
    line.firstMatch(of: regex)?.output
  }.map { match in
    (match.key, (left: match.left, right: match.right))
  }

  let map = Dictionary(parsed, uniquingKeysWith: { $1 })
  return (sequence, map)
}

extension Collection where Element: BinaryInteger {
  fileprivate var lcm: Element {
    guard let first else { return .zero }
    return reduce(first, lcm(_:_:))
  }
}

private func lcm<E: BinaryInteger>(_ lhs: E, _ rhs: E) -> E {
  lhs * rhs / gcd(lhs, rhs)
}

private func gcd<E: BinaryInteger>(_ lhs: E, _ rhs: E) -> E {
  var lhs = lhs
  var rhs = rhs
  while lhs != rhs {
    if lhs > rhs {
      lhs -= rhs
    } else {
      rhs -= lhs
    }
  }
  return rhs
}

import Core
import Foundation

extension Year2023 {
  struct Day07 {
    private let data: String

    init(data: String) {
      self.data = data
    }
  }
}

extension Year2023.Day07: AdventDay {
  func part1() -> Any {
    solve {
      Line($0, joker: false)
    }
  }

  func part2() -> Any {
    solve {
      Line($0, joker: true)
    }
  }

  private func solve(line: (Substring) -> Line) -> UInt {
    let lines = data.split(separator: "\n").map(line)
    return
      lines
      .sorted(using: KeyPathComparator(\.hand))
      .enumerated()
      .map { index, line in
        UInt(index + 1) * line.bid
      }
      .reduce(0, +)
  }
}

private struct Line {
  let hand: Hand
  let bid: UInt

  init<S: StringProtocol>(_ line: S, joker: Bool) {
    let space = line.firstIndex(of: " ")!
    hand = Hand(line.prefix(upTo: space), joker: joker)
    bid = UInt(String(line.suffix(from: line.index(after: space)))) ?? 0
  }
}

private struct Hand: Comparable, CustomStringConvertible {
  init(_ labels: [Label], joker: Bool) {
    self.labels = labels
    self.combo = Combo(labels, joker: joker)
  }

  init<S: StringProtocol>(_ s: S, joker: Bool) {
    self.init(s.map { Label($0, joker: joker) }, joker: joker)
  }

  static func < (lhs: Hand, rhs: Hand) -> Bool {
    guard lhs.combo == rhs.combo else {
      return lhs.combo < rhs.combo
    }
    return lhs.labels.lexicographicallyPrecedes(rhs.labels)
  }

  var description: String {
    "\(labels.map(\.description).joined(separator: "")) \(combo)"
  }

  private let labels: [Label]
  private let combo: Combo
}

private enum Combo: Comparable {
  case one
  case two
  case doubleTwo
  case three
  case threeTwo
  case four
  case five

  init(_ labels: [Label], joker: Bool) {
    guard joker else {
      self.init(labels)
      return
    }
    let (others, jokers) = labels.partitioned(by: \.isJoker)
    guard !jokers.isEmpty else {
      self.init(labels)
      return
    }
    self =
      Set(others).map { other in
        Combo(others + Array(repeating: other, count: jokers.count))
      }.max() ?? Combo(labels)
  }

  private init(_ labels: [Label]) {
    let counts = Dictionary(grouping: labels, by: \.rank).values.map(\.count).sorted()

    switch counts {
    case [5]: self = .five
    case [1, 4]: self = .four
    case [2, 3]: self = .threeTwo
    case [1, 1, 3]: self = .three
    case [1, 2, 2]: self = .doubleTwo
    case [1, 1, 1, 2]: self = .two
    default: self = .one
    }
  }
}

private struct Label: Comparable, Hashable, CustomStringConvertible {
  init(_ character: Character, joker: Bool) {
    switch character {
    case "2"..."9": rank = character.wholeNumberValue ?? 0
    case "T": rank = 10
    case "J" where joker:
      rank = 1
      isJoker = true
    case "J": rank = 11
    case "Q": rank = 12
    case "K": rank = 13
    case "A": rank = 14
    default: rank = 0
    }
  }

  static func < (lhs: Label, rhs: Label) -> Bool {
    lhs.rank < rhs.rank
  }

  var description: String {
    switch rank {
    case 2...9: return "\(rank)"
    case 10: return "T"
    case 1, 11: return "J"
    case 12: return "Q"
    case 13: return "K"
    case 14: return "A"
    default: return "?"
    }
  }

  var rank: Int
  var isJoker = false
}

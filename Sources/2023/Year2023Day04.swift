import Core

extension Year2023 {
  struct Day04 {
    private let data: String

    init(data: String) {
      self.data = data
    }
  }
}

extension Year2023.Day04: AdventDay {
  func part1() -> Any {
    data
      .split(separator: "\n")
      .map(Card.init)
      .map(\.score)
      .reduce(0, +)
  }

  func part2() -> Any {
    let cards =
      data
      .split(separator: "\n")
      .map(Card.init)
    var wins = Array(repeating: 1, count: cards.count)
    for i in wins.indices where cards[i].matches > 0 {
      for j in (i + 1)...(i + cards[i].matches) {
        wins[j] += wins[i]
      }
    }

    return wins.reduce(0, +)
  }
}

private struct Card {
  let matches: Int

  init<S: StringProtocol>(_ string: S) {
    guard let colon = string.firstIndex(of: ":"),
      let sep = string.firstIndex(of: "|")
    else {
      matches = 0
      return
    }

    let info = string.suffix(from: string.index(after: colon))
    let winning = Set(
      info
        .prefix(upTo: sep)
        .split(separator: " ")
        .compactMap { UInt($0) }
    )
    let yours = Set(
      info
        .suffix(from: string.index(after: sep))
        .split(separator: " ")
        .compactMap { UInt($0) }
    )
    matches = winning.intersection(yours).count
  }

  var score: UInt {
    2 << (matches - 2)
  }
}

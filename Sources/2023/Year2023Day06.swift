import Core

extension Year2023 {
  struct Day06 {
    private let data: String

    init(data: String) {
      self.data = data
    }
  }
}

extension Year2023.Day06: AdventDay {
  func part1() -> Any {
    struct Race {
      let time: UInt
      let distance: UInt
    }

    let lines = data.split(separator: "\n")
    let races = zip(
      lines.first?.split(separator: " ") ?? [],
      lines.last?.split(separator: " ") ?? []
    ).compactMap { time, distance -> Race? in
      guard let time = UInt(String(time)), let distance = UInt(String(distance)) else {
        return nil
      }
      return Race(time: time, distance: distance)
    }

    return races.map { race in
      (0..<race.time).filter { holdTime in
        reach(hold: holdTime, time: race.time) > race.distance
      }.count
    }
    .reduce(1, *)
  }

  func part2() -> Any {
    let lines = data.split(separator: "\n")
    func number<S: StringProtocol>(from line: S) -> UInt {
      UInt(line.split(separator: " ").dropFirst().joined(separator: "")) ?? 0
    }
    let time = lines.first.map(number(from:)) ?? 0
    let distance = lines.last.map(number(from:)) ?? 0

    var l = 0 as UInt
    var r = time / 2 + 1

    while l < r {
      let m = l + (r - l) / 2
      if reach(hold: m, time: time) <= distance {
        l = m + 1
      } else {
        r = m
      }
    }

    return time - l * 2 + 1
  }
}

private func reach(hold: UInt, time: UInt) -> UInt {
  hold * (time - hold)
}

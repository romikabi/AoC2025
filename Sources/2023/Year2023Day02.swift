import Core

extension Year2023 {
  struct Day02 {
    private let games: [Game]
    private let verbose: Bool

    init(data: String) {
      self.init(data: data, verbose: false)
    }
  }
}

extension Year2023.Day02: AdventDay {
  init(data: String, verbose: Bool) {
    self.verbose = verbose
    games = data.split(separator: "\n").map { line in
      let game = Game(line)
      if verbose {
        print(line, "-", game)
      }
      return game
    }
  }

  func part1() -> Any {
    let max = Round(red: 12, green: 13, blue: 14)
    if verbose {
      for game in games {
        print(game.isPossible(max: max) ? "+" : "-", game)
      }
    }
    return games.filter { game in
      game.isPossible(max: max)
    }.map(\.index).reduce(0, +)
  }

  func part2() -> Any {
    if verbose {
      for game in games {
        print(game.power, game)
      }
    }
    return games.map(\.power).reduce(0, +)
  }

  private struct Game: CustomStringConvertible {
    let index: UInt
    let rounds: [Round]

    init<S: StringProtocol>(_ string: S) {
      let parts = string.split(separator: ":")
      index =
        parts
        .first?
        .split(separator: " ")
        .last
        .map { String.init($0) }
        .flatMap(UInt.init) ?? 0
      rounds =
        parts
        .last?
        .split(separator: ";")
        .map { Round($0) } ?? []
    }

    func isPossible(max: Round) -> Bool {
      rounds.allSatisfy { round in
        round.isPossible(max: max)
      }
    }

    var power: UInt {
      required(\.red) * required(\.green) * required(\.blue)
    }

    private func required(_ v: (Round) -> UInt) -> UInt {
      rounds.map(v).max() ?? 0
    }

    var description: String {
      "Game \(index): " + rounds.map(\.description).joined(separator: "; ")
    }
  }

  private struct Round: CustomStringConvertible {
    let red: UInt
    let green: UInt
    let blue: UInt

    init(red: UInt, green: UInt, blue: UInt) {
      self.red = red
      self.green = green
      self.blue = blue
    }

    init<S: StringProtocol>(_ string: S) {
      let dict = Dictionary(
        string.split(separator: ",").map { cubeCount in
          let parts = cubeCount.split(separator: " ")
          return (
            String(parts.last!.trimmingCharacters(in: .whitespaces)),
            String(parts.first!.trimmingCharacters(in: .whitespaces))
          )
        },
        uniquingKeysWith: { $1 }
      )

      red = dict["red"].flatMap(UInt.init) ?? 0
      green = dict["green"].flatMap(UInt.init) ?? 0
      blue = dict["blue"].flatMap(UInt.init) ?? 0
    }

    func isPossible(max: Round) -> Bool {
      red <= max.red && green <= max.green && blue <= max.blue
    }

    var description: String {
      "\(red) red, \(green) green, \(blue) blue"
    }
  }
}

import Core

extension Year2023 {
  struct Day11 {
    private let data: String

    init(data: String) {
      self.data = data
    }
  }
}

extension Year2023.Day11: AdventDay {
  func part1() -> Any {
    solve(warp: 2)
  }

  func part2() -> Any {
    solve(warp: 1_000_000)
  }

  private func solve(warp: Int) -> Any {
    struct Space {
      var galaxy: Bool
      var horizontal = 1
      var vertical = 1
    }
    var spaces = data.split(separator: "\n").map { line in
      line.map { character in
        Space(galaxy: character == "#")
      }
    }

    for i in spaces.indices {
      if !spaces[i].contains(where: \.galaxy) {
        for j in spaces[i].indices {
          spaces[i][j].vertical = warp
        }
      }
    }

    for j in spaces.first?.indices ?? 0..<0 {
      if !spaces.indices.contains(where: { i in spaces[i][j].galaxy }) {
        for i in spaces.indices {
          spaces[i][j].horizontal = warp
        }
      }
    }

    let galaxies = spaces.indices.flatMap { i in
      spaces[i].indices.compactMap { j in
        spaces[i][j].galaxy ? (i: i, j: j) : nil
      }
    }

    let distances =
      galaxies
      .permutations(ofCount: 2)
      .map { permutation in
        (permutation.first!, permutation.last!)
      }
      .map { first, second -> Int in
        var i = min(first.i, second.i)
        var j = min(first.j, second.j)
        let maxi = max(first.i, second.i)
        let maxj = max(first.j, second.j)
        var sum = 0
        while i < maxi {
          sum += spaces[i][j].vertical
          i += 1
        }
        while j < maxj {
          sum += spaces[i][j].horizontal
          j += 1
        }
        return sum
      }
    return distances.reduce(0, +) / 2
  }
}

import Core

extension Year2023 {
  struct Day03 {
    private let data: String

    init(data: String) {
      self.data = data
    }
  }
}

extension Year2023.Day03: AdventDay {
  func part1() -> Any {
    enum Node: Equatable {
      case gap
      case symbol
      case digit(Int)

      init(_ character: Character) {
        if character == "." {
          self = .gap
        } else if let digit = character.wholeNumberValue {
          self = .digit(digit)
        } else {
          self = .symbol
        }
      }
    }

    let grid = data.split(separator: "\n").map { $0.map(Node.init) }

    func hasNeighboringSymbol(i: Int, j: Int) -> Bool {
      for x in (i - 1)...(i + 1) where grid.indices.contains(x) {
        for y in (j - 1)...(j + 1) where grid.indices.contains(y) {
          if grid[x][y] == .symbol {
            return true
          }
        }
      }
      return false
    }

    var sum = 0
    for i in grid.indices {
      var number = 0
      var counts = false
      for j in grid[i].indices {
        switch grid[i][j] {
        case .gap, .symbol:
          if counts || grid[i][j] == .symbol {
            sum += number
          }
          number = 0
          counts = false
        case .digit(let digit):
          number = number * 10 + digit
          counts = counts || hasNeighboringSymbol(i: i, j: j)
        }
      }
      if counts {
        sum += number
      }
      number = 0
      counts = false
    }
    return sum
  }

  func part2() -> Any {
    struct Gear: Hashable {
      let i: Int
      let j: Int
    }

    let grid = data.split(separator: "\n").map(Array.init)
    let gears = grid.indices.flatMap { i in
      grid[i].indices.compactMap { j in
        if grid[i][j] == "*" {
          return Gear(i: i, j: j)
        }
        return nil
      }
    }

    func numbers(around gear: Gear) -> [Int] {
      var suspects = Set<Gear>()
      for x in (gear.i - 1)...(gear.i + 1) where grid.indices.contains(x) {
        for y in (gear.j - 1)...(gear.j + 1) where grid[x].indices.contains(y) {
          suspects.insert(Gear(i: x, j: y))
        }
      }
      suspects.remove(gear)

      var nums = [Int]()
      while let sus = suspects.popFirst() {
        guard grid[sus.i][sus.j].isNumber else { continue }

        var l = sus.j - 1
        while grid[sus.i].indices.contains(l), grid[sus.i][l].isNumber {
          suspects.remove(Gear(i: sus.i, j: l))
          l -= 1
        }
        l += 1

        var r = sus.j + 1
        while grid[sus.i].indices.contains(r), grid[sus.i][r].isNumber {
          suspects.remove(Gear(i: sus.i, j: r))
          r += 1
        }
        r -= 1

        nums.append(Int(String(grid[sus.i][l...r]))!)
      }

      return nums
    }

    return gears.map { gear in
      let nums = numbers(around: gear)
      if nums.count == 2 {
        return nums[0] * nums[1]
      }
      return 0
    }
    .reduce(0, +)
  }
}

import Core

extension Year2023 {
  struct Day10 {
    private let data: String

    init(data: String) {
      self.data = data
    }
  }
}

extension Year2023.Day10: AdventDay {
  func part1() -> Any {
    let pipes = data.split(separator: "\n").map { $0.map { $0 } }
    let start = startIndex(in: pipes)

    var steps = 0
    var last = start
    var pipe = start
    repeat {
      let t = pipe
      pipe = connectedPipes(around: pipe, in: pipes).first { $0 != last }!
      last = t
      steps += 1
    } while pipe != start

    return steps / 2
  }

  func part2() -> Any {
    let pipes = data.split(separator: "\n").map { $0.map { $0 } }
    let start = startIndex(in: pipes)

    enum Tile {
      case ground
      case boundary
      case pipe
    }

    var pureGrid = pipes.map { row in
      Array(repeating: "." as Character, count: row.count)
    }

    var last = start
    var pipe = start
    repeat {
      let t = pipe
      pipe = connectedPipes(around: pipe, in: pipes).first { $0 != last }!
      last = t
      setTile(tile(at: pipe, in: pipes)!, at: pipe, in: &pureGrid)
    } while pipe != start

    // specific to the input
    setTile("J", at: start, in: &pureGrid)

    return pureGrid.reduce(into: 0) { result, row in
      var inside = false
      var e: Expectation?
      for tile in row {
        switch tile {
        case "." where inside:
          result += 1
        case "|":
          inside.toggle()
        case let x where x == e?.toggle:
          inside.toggle()
          e = nil
        case let x where x == e?.keep:
          e = nil
        default:
          if let exp = expectation(after: tile) {
            e = exp
          }
        }
      }
    }
  }
}

private struct Index: Hashable {
  let i: Int
  let j: Int

  func applyDelta(_ delta: Delta) -> Index {
    switch delta {
    case .i(let di):
      return Index(i: i + di, j: j)
    case .j(let dj):
      return Index(i: i, j: j + dj)
    }
  }
}

private enum Delta: Hashable {
  case i(Int)
  case j(Int)
}

private typealias Expectation = (toggle: Character, keep: Character)

private func connectedPipes(around index: Index, in pipes: [[Character]]) -> [Index] {
  guard let tile = tile(at: index, in: pipes) else { return [] }
  return connections(tile: tile).map(index.applyDelta).filter {
    connected($0, index, in: pipes)
  }
}

private func connected(_ lhs: Index, _ rhs: Index, in pipes: [[Character]]) -> Bool {
  guard let l = tile(at: lhs, in: pipes),
    let r = tile(at: rhs, in: pipes)
  else { return false }
  return connections(tile: l).map(lhs.applyDelta).contains(rhs)
    && connections(tile: r).map(rhs.applyDelta).contains(lhs)
}

private func connections(tile: Character) -> Set<Delta> {
  switch tile {
  case "-": return [.j(-1), .j(1)]
  case "|": return [.i(-1), .i(1)]
  case "F": return [.j(1), .i(1)]
  case "J": return [.j(-1), .i(-1)]
  case "L": return [.j(1), .i(-1)]
  case "7": return [.j(-1), .i(1)]
  case "S": return [.i(-1), .i(1), .j(-1), .j(1)]
  default: return []
  }
}

private func tile<T>(at index: Index, in pipes: [[T]]) -> T? {
  guard pipes.indices.contains(index.i), pipes[index.i].indices.contains(index.j) else {
    return nil
  }
  return pipes[index.i][index.j]
}

private func setTile<T>(_ tile: T, at index: Index, in pipes: inout [[T]]) {
  guard pipes.indices.contains(index.i), pipes[index.i].indices.contains(index.j) else {
    return
  }
  pipes[index.i][index.j] = tile
}

private func startIndex(in pipes: [[Character]]) -> Index {
  pipes.lazy.indices.flatMap { i in
    pipes[i].lazy.indices.map { j in
      Index(i: i, j: j)
    }
  }.first { index in
    pipes[index.i][index.j] == "S"
  }!
}

private func expectation(after tile: Character) -> Expectation? {
  switch tile {
  case "L": return ("7", "J")
  case "F": return ("J", "7")
  default: return nil
  }
}

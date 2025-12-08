import Core
import Foundation
import HeapModule

extension Year2025 {
  struct Day08 {
    private let data: String
    private let maxSteps: Int

    init(data: String, maxSteps: Int) {
      self.data = data
      self.maxSteps = maxSteps
    }

    init(data: String) {
      self.data = data
      self.maxSteps = 1000
    }
  }
}

extension Year2025.Day08: AdventDay {
  func part1() -> Int {
    var solver = Solver(data: data, maxSteps: maxSteps)
    return solver.part1()
  }

  func part2() -> Int {
    var solver = Solver(data: data, maxSteps: maxSteps)
    return solver.part2()
  }
}

private struct Solver {
  private let boxes: [[Int]]
  private let distances: [Distance]
  private let maxSteps: Int

  init(data: String, maxSteps: Int) {
    self.maxSteps = maxSteps
    boxes = parseBoxes(from: data)
    distances = calculateDistances(between: boxes)
  }

  mutating func part1() -> Int {
    var circuits = boxes.indices.map { Set([$0]) }
    var heap = Heap(distances)
    for _ in 0..<maxSteps {
      guard let distance = heap.popMin() else { break }
      guard
        let indexFrom = circuits.firstIndex(where: {
          $0.contains(distance.from)
        }),
        let indexTo = circuits.firstIndex(where: {
          $0.contains(distance.to)
        }),
        indexFrom != indexTo
      else { continue }
      circuits[indexFrom].formUnion(circuits[indexTo])
      circuits[indexTo] = []
    }
    return circuits.map(\.count).sorted(by: >)[..<3].reduce(1, *)
  }

  mutating func part2() -> Int {
    var circuits = boxes.indices.map { Set([$0]) }
    var nonZeros = boxes.count
    var heap = Heap(distances)
    while true {
      guard let distance = heap.popMin() else { break }
      guard
        let indexFrom = circuits.firstIndex(where: {
          $0.contains(distance.from)
        }),
        let indexTo = circuits.firstIndex(where: {
          $0.contains(distance.to)
        }),
        indexFrom != indexTo
      else { continue }
      circuits[indexFrom].formUnion(circuits[indexTo])
      circuits[indexTo] = []
      nonZeros -= 1
      if nonZeros == 1 {
        return boxes[distance.from][0] * boxes[distance.to][0]
      }
    }
    return 0
  }
}

private struct Distance: Comparable {
  static func < (lhs: Distance, rhs: Distance) -> Bool {
    lhs.distance < rhs.distance
  }

  let from: Int
  let to: Int
  let distance: Double
}

private func parseBoxes(from data: String) -> [[Int]] {
  data
    .split(separator: "\n")
    .map { line in
      line
        .trimmingCharacters(in: .whitespaces)
        .split(separator: ",")
        .compactMap { Int($0) }
    }
}

private func calculateDistances(between boxes: [[Int]]) -> [Distance] {
  boxes.indices.dropFirst().flatMap { i in
    boxes[..<i].indices.map { j in
      let sum = zip(boxes[i], boxes[j]).reduce(into: 0) { sum, coordinates in
        let distance = coordinates.0 - coordinates.1
        sum += distance * distance
      }
      return Distance(from: i, to: j, distance: sqrt(Double(sum)))
    }
  }
}

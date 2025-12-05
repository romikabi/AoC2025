import Core
import Foundation

extension Year2023 {
  struct Day05 {
    private let data: String

    init(data: String) {
      self.data = data
    }
  }
}

extension Year2023.Day05: AdventDay {
  func part1() -> Any {
    let almanac = Almanac(part1: data)
    return solve(almanac)
  }

  func part2() -> Any {
    let almanac = Almanac(part2: data)
    return solve(almanac)
  }

  private func solve(_ almanac: Almanac) -> UInt {
    var ranges = almanac.seeds
    for maps in almanac.maps {
      ranges = ranges.flatMap { range in
        let overlaps = maps.filter { range.overlaps($0.source) }
        return overlaps.map { map in
          range
            .clamped(to: map.source)
            .shift(by: -Int(map.source.lowerBound))
            .relative(to: map.target)
            .shift(by: Int(map.target.lowerBound))
        }
      }
    }
    return ranges.map(\.lowerBound).min() ?? 0
  }
}

private struct Almanac {
  let seeds: [Range<UInt>]
  let maps: [[Map]]

  init(part1 s: String) {
    let splits = s.split(separator: "\n\n")

    seeds = splits[0].split(separator: " ").map(String.init).compactMap(UInt.init)
      .map { $0..<$0 + 1 }

    maps = splits.dropFirst().map(makeMap)
  }

  init(part2 s: String) {
    let splits = s.split(separator: "\n\n")

    seeds = splits[0].split(separator: " ").map(String.init).compactMap(UInt.init)
      .chunks(ofCount: 2)
      .map { $0.first!..<$0.first! + $0.last! }

    maps = splits.dropFirst().map(makeMap)
  }
}

private struct Map {
  let source: Range<UInt>
  let target: Range<UInt>
}

extension Map {
  fileprivate init(_ number: UInt) {
    self.init(number..<number)
  }
  fileprivate init(_ range: Range<UInt>) {
    source = range
    target = range
  }
}

private func makeMap<S: StringProtocol>(section: S) -> [Map] {
  let genuineMaps = section.split(separator: "\n").dropFirst()
    .map { line in
      let nums = line.split(separator: " ")
      return (UInt(nums[0]) ?? 0, UInt(nums[1]) ?? 0, UInt(nums[2]) ?? 1)
    }
    .map { s2, s1, l in
      Map(source: s1..<s1 + l, target: s2..<s2 + l)
    }
    .sorted(using: KeyPathComparator(\.source.lowerBound))

  let maps = [Map(.min)] + genuineMaps + [Map(.max)]

  return maps.adjacentPairs().flatMap { l, r in
    [l, Map(l.source.upperBound..<r.source.lowerBound)]
  }
  .filter { !$0.source.isEmpty }
}

extension Range where Bound: Strideable, Bound.Stride: BinaryInteger {
  fileprivate func shift(by stride: Bound.Stride) -> Range {
    lowerBound.advanced(by: stride)..<upperBound.advanced(by: stride)
  }
}

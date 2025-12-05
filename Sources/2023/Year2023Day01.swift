import Core

extension Year2023 {
  struct Day01 {
    private let data: String
    private let digits: [String: Int]
  }
}

extension Year2023.Day01: AdventDay {
  init(data: String) {
    self.data = data
    self.digits = [
      "one": 1,
      "two": 2,
      "three": 3,
      "four": 4,
      "five": 5,
      "six": 6,
      "seven": 7,
      "eight": 8,
      "nine": 9,
      "0": 0,
      "1": 1,
      "2": 2,
      "3": 3,
      "4": 4,
      "5": 5,
      "6": 6,
      "7": 7,
      "8": 8,
      "9": 9,
    ]
  }

  func part1() -> Any {
    data
      .split(whereSeparator: \.isNewline)
      .map { line in
        (line.first(where: \.isNumber), line.last(where: \.isNumber))
      }
      .map { f, l in
        Int("\(f!)\(l!)")!
      }
      .reduce(0, +)
  }

  func part2() -> Any {
    let regex = try! Regex(digits.keys.map { "(\($0))" }.joined(separator: "|"))
    var mutableData = data
    mutableData.replace(regex) { match in
      let m = String(data[match.range])
      return "\(digits[m]!)\(m.dropFirst())"
    }
    return
      mutableData
      .split(whereSeparator: \.isNewline)
      .map { line in
        let matches = line.matches(of: regex)
        return (String(line[matches.first!.range]), String(line[matches.last!.range]), line)
      }
      .map {
        digits[$0.0]! * 10 + digits[$0.1]!
      }
      .reduce(0, +)
  }
}

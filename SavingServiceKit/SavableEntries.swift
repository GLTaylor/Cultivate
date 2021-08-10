import Foundation

public struct SavableQuestionAnswer: Codable, Identifiable {

    public init(id: UUID, question: String, answer: Answer) {
        self.id = id
        self.question = question
        self.answer = answer
    }

    public enum Answer: Codable, Equatable {
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            guard let type = try? container.decode(AnswerType.self, forKey: .type) else {
                fatalError("Undefined answer type!")
            }

            switch type {
            case .slider:
                self = .slider(try container.decode(Int.self, forKey: .data))
            case .text:
                self = .text(try container.decode(String.self, forKey: .data))
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            switch self {
            case .slider(let value):
                try container.encode(AnswerType.slider, forKey: .type)
                try container.encode(value, forKey: .data)
            case .text(let value):
                try container.encode(AnswerType.text, forKey: .type)
                try container.encode(value, forKey: .data)
            }
        }

        case slider(Int)
        case text(String)

        private enum CodingKeys: String, CodingKey {
            case data, type
        }
    }

    public enum AnswerType: String, Codable, Equatable {
        case slider, text
    }

    public let id: UUID
    public let question: String
    public let answer: Answer
}

public struct SavableActivity: Codable, Identifiable {

    public init(id: UUID, timestamp: Date, resultSet: [SavableQuestionAnswer]) {
        self.id = id
        self.timestamp = timestamp
        self.resultSet = resultSet
    }

    public let id: UUID
    public let timestamp: Date
    public let resultSet: [SavableQuestionAnswer]
}

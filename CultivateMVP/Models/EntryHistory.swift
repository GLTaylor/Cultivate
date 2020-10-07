import Foundation

// Entries
public struct EntryHistory: Equatable {
    public var activities: [Activity]

    public init(activities: [Activity]) {
        self.activities = activities
    }

    public struct Activity: Identifiable, Equatable {
        public static func == (lhs: EntryHistory.Activity, rhs: EntryHistory.Activity) -> Bool {
            return lhs.resultSet ==  rhs.resultSet
        }

        // id is required for table view to work properly if I use a table view
        public let id: UUID
        public let timestamp: Date
        public let resultSet: [JournalQuestionAnswer]

        public init(id: UUID,
                    timestamp: Date,
                    resultSet: [JournalQuestionAnswer]) {
            self.id = id
            self.timestamp = timestamp
            self.resultSet = resultSet
        }
    }

    public static let empty = EntryHistory(activities: [])
}

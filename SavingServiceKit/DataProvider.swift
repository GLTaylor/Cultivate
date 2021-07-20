import Foundation

public struct DataProvider {
    // fix the type
    public let saveData: ([SavableActivity]) throws -> Void
    public let getAllData: () throws -> [SavableActivity]

    private static var dataSourceURL: URL {
        let docPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return docPath.appendingPathComponent("entries").appendingPathExtension("json")
    }

   private static let encoder = JSONEncoder()
   private static let decoder = JSONDecoder()

    public static let live = DataProvider(
        saveData: { savableActivities in
            let data = try encoder.encode(savableActivities)
            try data.write(to: dataSourceURL)
        },
        getAllData: {
            let data = try Data(contentsOf: dataSourceURL)
            return try decoder.decode([SavableActivity].self, from: data)
        })

    public static let mock = DataProvider(
        saveData: { _ in

        },
        getAllData: {
            []
        })
}

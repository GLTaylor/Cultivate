//import Foundation
//
//// FOR LATER - can use this with some sort of remotely located questions provider, that needs to be loaded and such.
//
//
//public struct AppEnvironment {
//    var dateProvider: () -> Date
//    var uuid: () -> UUID
//
//    public static let live = AppEnvironment(
//        dateProvider: Date.init,
//        uuid: UUID.init
//    )
//}
//#if DEBUG
//extension AppEnvironment {
//    static let fakeUUID = UUID()
//    public static let mock = AppEnvironment(
//        dateProvider: { Date.init(timeIntervalSince1970: 10)},
//        uuid: { .fakeUUID }
//    )
//}
//#endif
//
//#if DEBUG
//public extension UUID {
//    static let fakeUUID = UUID()
//}
//#endif

import Foundation

enum DateHelper {

    private static var rssDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        return dateFormatter
    }()

    private static var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MMM d, HH:mm"
        return dateFormatter
    }()

    static func rssDateFromString(_ string: String) -> Date? {
        return self.rssDateFormatter.date(from: string)
    }

    static func dateStringFromDate(_ date: Date) -> String {
        return self.dateFormatter.string(from: date)
    }
}

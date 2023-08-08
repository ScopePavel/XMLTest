import Foundation

struct DateHelper {

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

    /// Возвращает дату `rss` новости  из строки формата «E, d MMM yyyy HH:mm:ss Z»
    /// Метод может вернуть nil, в случае невозможности создания даты из переданной строки.
    ///
    /// - Parameter string: Исходное строковое представление даты в формате «E, d MMM yyyy HH:mm:ss Z»
    /// - Returns: Дата из исходной строки.
    static func rssDateFromString(_ string: String) -> Date? {
        return self.rssDateFormatter.date(from: string)
    }

    /// Возвращает строку даты
    ///
    /// - Parameter date: Дата из которой будет получена строка
    /// - Returns: Строка в формате «MMM d, HH:mm»
    static func dateStringFromDate(_ date: Date) -> String {
        return self.dateFormatter.string(from: date)
    }
}

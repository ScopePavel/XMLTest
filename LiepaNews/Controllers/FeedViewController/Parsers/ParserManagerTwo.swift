import Foundation
import SwiftyXMLParser

enum RSSConstants: String {
    case item
    case title
    case description
    case link
    case guid
    case enclosure
    case pubDate
    case channel
    case url
    case rss
}

final class ParserManagerTwo: ParserProtocol {
    let id: String
    private var feeds: [FeedCellViewModel] = []
    private var complition: (([FeedCellViewModel]) -> Void)?

    init(id: String) {
        self.id = id
    }

    func getData(complition: (([FeedCellViewModel]) -> Void)?) {
        feeds = []
        self.complition = complition
        guard let url = URL(string: id) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error ?? "Unknown error")
                return
            }

            let xml = XML.parse(data)

            xml[
                RSSConstants.rss.rawValue,
                RSSConstants.channel.rawValue,
                RSSConstants.item.rawValue
            ].forEach { [weak self] item in
                let title = item[RSSConstants.title.rawValue].text
                let description = item[RSSConstants.description.rawValue].text
                let link = item[RSSConstants.link.rawValue].text
                let guId = item[RSSConstants.guid.rawValue].text
                let url = item[RSSConstants.enclosure.rawValue].element?.attributes["url"]
                let pubDate = item[RSSConstants.pubDate.rawValue].text

                self?.feeds.append(FeedCellViewModel(title: title,
                                                     datePub: pubDate,
                                                     description: description,
                                                     url: url,
                                                     source: link,
                                                     guId: guId))

            }
            complition?(self.feeds)
        }
        task.resume()
    }
}

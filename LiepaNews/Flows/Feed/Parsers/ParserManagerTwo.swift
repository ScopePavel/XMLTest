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

    // MARK: - Internal properties

    let url: String

    // MARK: - Private properties

    private var feeds: [FeedModel] = []
    private var complition: (([FeedModel]) -> Void)?

    // MARK: - Init

    init(url: String) {
        self.url = url
    }

    // MARK: - Public

    func getData(complition: (([FeedModel]) -> Void)?) {
        feeds = []
        self.complition = complition
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }

            if error != nil {
                self.complition?(self.feeds)
            }

            guard let data = data else {
                print(error ?? "Unknown error")
                self.complition?(self.feeds)
                return
            }

            let xml = XML.parse(data)

            xml[
                RSSConstants.rss.rawValue,
                RSSConstants.channel.rawValue,
                RSSConstants.item.rawValue
            ].forEach { [weak self] item in
                let title = item[RSSConstants.title.rawValue].text ?? ""
                let description = item[RSSConstants.description.rawValue].text
                let link = item[RSSConstants.link.rawValue].text ?? ""
                let url = item[RSSConstants.enclosure.rawValue].element?.attributes["url"]
                let pubDate = item[RSSConstants.pubDate.rawValue].text ?? ""

                self?.feeds.append(RSSFeedModel(
                    title: title,
                    descriptionNews: description,
                    source: link,
                    date: pubDate,
                    imageURLString: url
                ))

            }
            complition?(self.feeds)
        }
        task.resume()
    }
}

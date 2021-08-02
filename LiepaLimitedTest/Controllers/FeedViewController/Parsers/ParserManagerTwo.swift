//
//  ParserManagerTwo.swift
//  LiepaLimitedTest
//
//  Created by Паронькин Павел on 29.07.2021.
//

import Foundation
import SwiftyXMLParser


enum RSSConstants: String {
    case item = "item"
    case title = "title"
    case description = "description"
    case link = "link"
    case guid = "guid"
    case enclosure = "enclosure"
    case pubDate = "pubDate"
    case channel = "channel"
    case url = "url"

    case rss = "rss"
}

final class ParserManagerTwo: ParserProtocol {

    init(urlString: String) {
        self.urlString = urlString
    }

    func getData(complition: (([FeedCellViewModel]) -> ())?) {
        feeds = []
        self.complition = complition
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print(error ?? "Unknown error")
                return
            }

            let xml = XML.parse(data)

            xml[RSSConstants.rss.rawValue, RSSConstants.channel.rawValue, RSSConstants.item.rawValue].forEach { [weak self] item in
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

    private var feeds: [FeedCellViewModel] = []
    private var complition: (([FeedCellViewModel]) -> ())?
    private let urlString: String
}

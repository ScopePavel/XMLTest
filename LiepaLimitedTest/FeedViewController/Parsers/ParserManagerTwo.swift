//
//  ParserManagerTwo.swift
//  LiepaLimitedTest
//
//  Created by Паронькин Павел on 29.07.2021.
//

import Foundation
import SwiftyXMLParser

final class ParserManagerTwo: ParserProtocol {

    func getData(complition: (([FeedCellViewModel]) -> ())?) {
        feeds = []
        self.complition = complition
        guard let url = URL(string: "http://www.gazeta.ru/export/rss/lenta.xml") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print(error ?? "Unknown error")
                return
            }

            guard let xml = try? XML.parse(data) else {
                print("not parse XML")
                return
            }

            xml["rss", "channel", "item"].forEach { [weak self] item in
                if  let title = item["title"].text,
                    let description = item["description"].text,
                    let link = item["link"].text,
                    let url = item["enclosure"].element?.attributes["url"] {

                    self?.feeds.append(FeedCellViewModel(title: title, datePub: "date", description: description, url: url, source: link))
                }
            }
            complition?(self.feeds)
        }
        task.resume()
    }

    private var feeds: [FeedCellViewModel] = []
    private var complition: (([FeedCellViewModel]) -> ())?

    struct Item: Codable {
        let title: String
        let author: String
        let pubDate: String
        let description: String
        let url: String
    }
}

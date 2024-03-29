import Foundation

protocol ParserProtocol {
    var id: String { get }

    func getData(complition: (([FeedCellViewModel]) -> Void)?)
}

final class ParserManager: NSObject, ParserProtocol, XMLParserDelegate {
    var id: String
    private var feeds: [FeedCellViewModel] = []
    private var complition: (([FeedCellViewModel]) -> Void)?
    private var parserModel = ParserModel.defaultParserModel

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

            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }
        task.resume()
    }

    private struct ParserModel {
        var currentElement: String
        var title: String
        var description: String
        var url: String
        var link: String
        var guId: String

        static let defaultParserModel = ParserModel(currentElement: "",
                                                    title: "",
                                                    description: "",
                                                    url: "",
                                                    link: "",
                                                    guId: "")
    }
}

extension ParserManager {
    func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String: String] = [:]
    ) {
        parserModel.currentElement = elementName
        if elementName == RSSConstants.item.rawValue {
            parserModel = ParserModel.defaultParserModel
        }

        if elementName == RSSConstants.enclosure.rawValue {
            if let urlString = attributeDict[RSSConstants.url.rawValue] {
                parserModel.url = urlString
            }
        }
    }

    func parser(
        _ parser: XMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?
    ) {
        if elementName == RSSConstants.item.rawValue {
            feeds.append(FeedCellViewModel(
                title: parserModel.title,
                datePub: parserModel.link,
                description: parserModel.description,
                url: parserModel.url,
                source: parserModel.link,
                guId: parserModel.guId
            ))
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch parserModel.currentElement {
        case "title":
            parserModel.title += string
        case "link":
            parserModel.link += string
        case "description":
            parserModel.description += string
        case "guid":
            parserModel.guId += string
        default:
            break
        }
    }

    func parserDidEndDocument(_ parser: XMLParser) {
        complition?(feeds)
    }
}

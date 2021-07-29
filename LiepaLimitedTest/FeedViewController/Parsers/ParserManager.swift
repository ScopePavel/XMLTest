//
//  ParserManager.swift
//  LiepaLimitedTest
//
//  Created by 18529728 on 29.07.2021.
//

import Foundation

protocol ParserProtocol {
    func getData(complition: (([FeedCellViewModel]) -> ())?)
}

final class ParserManager: NSObject, ParserProtocol, XMLParserDelegate {

    func getData(complition: (([FeedCellViewModel]) -> ())?) {
        self.complition = complition
        guard let url = URL(string: "http://lenta.ru/rss") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
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


    private var feeds: [FeedCellViewModel] = []
    private var complition: (([FeedCellViewModel]) -> ())?






    private var parserModel = ParserModel.defaultParserModel

    private struct ParserModel {
        var currentElement: String
        var autor: String
        var title: String
        var descriptionFromServer: String
        var enclose: String

        static let defaultParserModel = ParserModel(currentElement: "",
                                                    autor: "",
                                                    title: "",
                                                    descriptionFromServer: "",
                                                    enclose: "")
    }
}


extension ParserManager {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        parserModel.currentElement = elementName
        if elementName == "item" {
            parserModel = ParserModel.defaultParserModel
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            feeds.append(FeedCellViewModel(title: parserModel.title, autor: parserModel.autor, description: parserModel.descriptionFromServer))
        }
    }


    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch parserModel.currentElement {
        case "title": parserModel.title += string
        case "autor": parserModel.autor += string
        case "description": parserModel.descriptionFromServer += string
        default: break
        }
    }

    func parserDidEndDocument(_ parser: XMLParser) {
        complition?(feeds)
    }
}

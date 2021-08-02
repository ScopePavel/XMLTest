//
//  ParsersConfigurator.swift
//  LiepaLimitedTest
//
//  Created by Паронькин Павел on 02.08.2021.
//

import Foundation

protocol ParsersConfiguratorProtocol {
    func getParsers() -> [ParserProtocol]
}

struct ParsersConfiguratorModel {
    let parser: ParserProtocol
    var isOn: Bool
}

enum ParserIds: String, CaseIterable {
    case gazeta = "gazeta"
    case lenta = "lenta"
}

final class ParsersConfigurator: ParsersConfiguratorProtocol {
    func getParsers() -> [ParserProtocol] {
        var parsers: [ParserProtocol] = []
        models.forEach { model in
            if model.value.isOn {
                parsers.append(model.value.parser)
            }
        }
        return parsers
    }

    init(models: [ParsersConfiguratorModel]) {
        self.models = [ : ]
        models.forEach { [weak self] parserModel in
            guard let self = self else { return }
            self.models.updateValue(parserModel, forKey: parserModel.parser.id)
        }

        NotificationCenter.default.addObserver(self, selector: #selector(isAddAction), name: LLNotifications.parsers, object: nil)
    }

    @objc private func isAddAction(_ notification: Notification) {
        ParserIds.allCases.forEach { id in
            if let value = notification.userInfo?[id.rawValue] as? Bool {
                models[id]?.isOn = value
            }
        }
    }

    private var models: [ParserIds: ParsersConfiguratorModel]
}

//
//  DeeplinkParser.swift
//  DeepLinkPDP
//
//  Created by Никита Лужбин on 04.06.2021.
//

import Foundation

class DeeplinkParser {

    // MARK: - Type Properties

    static let shared = DeeplinkParser()

    // MARK: - Instance Methods

    func parse(url: URL) -> DeeplinkType? {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true), let host = components.host else {
            return nil
        }

        var pathComponents = components.path.components(separatedBy: "/")

        pathComponents.removeFirst()

        switch host {
        case "profile":
            return DeeplinkType.profile

        case "feed":
            return DeeplinkType.feed

        case "feedItem":
            if let feedItemIdString = pathComponents.first, let id = Int(feedItemIdString) {
                return DeeplinkType.feedItem(id: id)
            } else {
                return nil
            }

        default:
            return nil
        }
    }
}

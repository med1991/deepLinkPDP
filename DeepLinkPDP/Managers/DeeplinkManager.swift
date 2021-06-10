//
//  DeeplinkManager.swift
//  DeepLinkPDP
//
//  Created by Никита Лужбин on 06.06.2021.
//

import Foundation
import UIKit

class DeeplinkManager {

    // MARK: - Type Properties

    static let shared = DeeplinkManager()

    // MARK: - Instance Properties

    var deeplinkType: DeeplinkType?

    // MARK: - Instance Methods

    func checkDeeplink() {
        guard let deeplinkType = self.deeplinkType else {
            print("Unknown deeplink")
            return
        }

        var deepLinkString: String

        switch deeplinkType {
        case .profile:
            deepLinkString = "Profile"

        case .feed:
            deepLinkString = "Feed"

        case .feedItem(id: let id):
            deepLinkString = "Feed Item. ID: \(id)"
        }

        self.presentAlert(title: "DeepLink", message: deepLinkString)

        self.deeplinkType = nil
    }

    @discardableResult
    func handleDeeplink(url: URL) -> Bool {
        let deepLinkType = DeeplinkParser.shared.parse(url: url)

        self.deeplinkType = deepLinkType

        return deepLinkType != nil
    }

    // MARK: -

    private func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: "DeepLink",
                                                message: message,
                                                preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)

        alertController.addAction(okAction)

        UIApplication.shared.keyWindow?.rootViewController?.present(alertController,
                                                                    animated: true,
                                                                    completion: nil)
    }
}

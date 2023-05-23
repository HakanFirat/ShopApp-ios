//
//  AppDelegate.swift
//  ShopApp
//
//  Created by Yunus İçmen on 8.05.2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        makeRootController()

        return true
    }

    private func makeRootController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.overrideUserInterfaceStyle = .light

        let viewController = HomeViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.isTranslucent = false

        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor(hexString: "3339FF")]
        navigationController.navigationBar.titleTextAttributes = textAttributes
        navigationController.navigationBar.barTintColor = .white

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

class BaseViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
    }
}

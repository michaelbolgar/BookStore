import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)

        window.rootViewController = HomeVC()
//        window.rootViewController = CategoriesVC()
//        window.rootViewController = LikesVC()
//        window.rootViewController = AccountVC()
        window.rootViewController = SearchResultVC()
    

        window.makeKeyAndVisible()
        self.window = window
    }
}


import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        
//
//        let appLaunchedBefore = UserDefaults.standard.bool(forKey: "appLaunchedBefore")
//        if appLaunchedBefore {
//            let mainVC = MainTabBarController()
//            let navigationController = UINavigationController(rootViewController: mainVC)
//            window?.rootViewController = navigationController
//        } else {
//            let onboardingVC = OnboardingViewController()
//            window?.rootViewController = onboardingVC
//        }
//        UserDefaults.standard.set(true, forKey: "appLaunchedBefore")
        
//        window?.rootViewController = OnboardingViewController()
        window?.rootViewController = RegistrationViewController()
        window?.makeKeyAndVisible()
    }
}


//
//  MainTabBarController.swift
//  BookStore
//
//  Created by Alexander Altman on 04.12.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    private var shouldAnimateSelectedTabBarItem = false

    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        animateSelectedTabBarItem()
        delegate = self
    }

        private func generateTabBar() {
            tabBar.backgroundColor = UIColor.customLightGray
            viewControllers = [
                makeVC(vc: NavigationViewController(rootViewController: HomeVC()), image: UIImage(named: "home_unselected"), selectedImage: UIImage(named:"home_selected"), title: "Home"),
                makeVC(vc: NavigationViewController(rootViewController: CategoriesVC()), image: UIImage(named: "categories_unselected"), selectedImage: UIImage(named: "categories_selected"), title: "Categories"),
                makeVC(vc: NavigationViewController(rootViewController: LikesVC()), image: UIImage(named: "heart_unselected"), selectedImage: UIImage(named: "heart_selected"), title: "Likes"),
                makeVC(vc: NavigationViewController(rootViewController: AccountVC()), image: UIImage(named: "account_unselected"), selectedImage: UIImage(named: "account_selected"), title: "Account"),
            ]

                let tabBarItemAppearance = UITabBarItem.appearance()
                let attributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.openSansBold(ofSize: 14)!,
                    .foregroundColor: UIColor.black
                ]
                tabBarItemAppearance.setTitleTextAttributes(attributes, for: .normal)
                tabBarItemAppearance.setTitleTextAttributes(attributes, for: .selected)
        }
    
    private func makeVC(vc: UIViewController, image: UIImage?, selectedImage: UIImage?, title: String) -> UIViewController {
        let offset: CGFloat = 5
        vc.tabBarItem.imageInsets = UIEdgeInsets(top: offset, left: 0, bottom: -offset, right: 0)
        vc.tabBarItem.image = image?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = selectedImage?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.title = title
        let titleOffset = UIOffset(horizontal: 0, vertical: 4)
        vc.tabBarItem.titlePositionAdjustment = titleOffset
        return vc
    }
    
    private func animateSelectedTabBarItem() {
        guard shouldAnimateSelectedTabBarItem else {
            return
        }
        
        guard let selectedViewController = selectedViewController else {
            return
        }
        
        guard let selectedIndex = viewControllers?.firstIndex(of: selectedViewController) else {
            return
        }
        
        let tabBarButton = tabBar.subviews[selectedIndex + 1]
        
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: [.curveEaseInOut], animations: {
                tabBarButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }) { _ in
                UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: [.curveEaseInOut], animations: {
                    tabBarButton.transform = CGAffineTransform.identity
                }, completion: nil)
            }
        
        shouldAnimateSelectedTabBarItem = false
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        shouldAnimateSelectedTabBarItem = true
        animateSelectedTabBarItem()
    }
}


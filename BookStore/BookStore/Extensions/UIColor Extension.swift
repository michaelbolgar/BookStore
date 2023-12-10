import UIKit

extension UIColor {
    
    static var customDarkGray: UIColor = {
        return UIColor (red: 184/255, green: 184/255, blue: 184/255, alpha: 1.0)
    }()
    
    static var customLightGray: UIColor = {
        return UIColor (red: 222/255, green: 222/255, blue: 222/255, alpha: 1.0)
    }()
    
    static var customBlack: UIColor = {
        return UIColor (red: 18/255, green: 18/255, blue: 18/255, alpha: 1.0)
    }()
    
    static var authDark: UIColor = {
        return UIColor (red: 18/255, green: 18/255, blue: 18/255, alpha: 1.0)
    }()
    
    static var background: UIColor = {
        if #available(iOS 13, *) {
            return UIColor (dynamicProvider: { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .light {
                    return UIColor.white
                } else {
                    return UIColor.systemGray4
                }
            })
        } else {
            return UIColor.white
        }
    }()
    
    static var elements: UIColor = {
        if #available(iOS 13, *) {
            return UIColor (dynamicProvider: { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .light {
                    return UIColor.customBlack
                } else {
                    return UIColor.customLightGray
                }
            })
        } else {
            return UIColor.customBlack
        }
    }()
    
    static var label: UIColor = {
        if #available(iOS 13, *) {
            return UIColor (dynamicProvider: { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .light {
                    return UIColor.customLightGray
                } else {
                    return UIColor.systemGray5
                }
            })
        } else {
            return UIColor.customLightGray
        }
    }()
    
    static var authBg: UIColor = {
        if #available(iOS 13, *) {
            return UIColor (dynamicProvider: { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .light {
                    return UIColor.white
                } else {
                    return UIColor.authDark
                }
            })
        } else {
            return UIColor.customLightGray
        }
    }()
}

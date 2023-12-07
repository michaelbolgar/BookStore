import UIKit
import SnapKit

extension UIButton {
    static func makeButton(text: String, buttonColor: UIColor, tintColor: UIColor, borderWidth: CGFloat) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(text, for: .normal)
        button.backgroundColor = buttonColor
        button.setTitleColor(tintColor, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.openSansRegular(ofSize: 14)
        button.layer.borderWidth = borderWidth
        

        return button
    }
}

import UIKit
import SnapKit

class HomeVC: UIViewController {

    //MARK: UI Elements

    let test = UILabel.makeLabel(text: "Hello, world!", font: UIFont.openSansRegular(ofSize: 40), textColor: UIColor.label)
    let testButton = UIButton.makeButton(text: "Ok", buttonColor: UIColor.elements, tintColor: .white)

    //MARK: View Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.background
        view.addSubview(test)
        view.addSubview(testButton)

        test.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        testButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(test.snp.bottom).offset(50)
            make.width.equalTo(320)
            make.height.equalTo(56)
        }
    }
}

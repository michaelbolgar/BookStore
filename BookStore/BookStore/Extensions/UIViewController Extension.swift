import UIKit

extension UIViewController {
    func setNavigationBar(title: String) {
        navigationItem.title = title
        navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.white,
         NSAttributedString.Key.font: UIFont.openSansRegular(ofSize: 14) ?? UIFont.systemFont(ofSize: 14, weight: .regular)]
        navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
    }

    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

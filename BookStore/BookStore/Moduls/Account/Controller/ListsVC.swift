import UIKit

final class ListsVC: UIViewController {
    
    enum Constants {
        static let wantToReadButtonText = "Want to read"
        static let classicBooksButtonText = "Classic books"
        static let readForFunButtonText = "Read for fun"
        
        static let spacingForMainStackView: CGFloat = 20
        static let mainStackViewTopInset: CGFloat = 20
        static let mainStackViewLeadingInset: CGFloat = 20
        static let mainStackViewTrailingInset: CGFloat = -20
        static let buttonLeadingInset: CGFloat = 15
        
        static let arrowImage = UIImage(systemName: "arrow.right")
    }
    
    private lazy var mainStackView: UIStackView = {
        let mainStackView = UIStackView()
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.spacing = Constants.spacingForMainStackView
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        return mainStackView
    }()
    
    private lazy var wantToReadButton: UIButton = {
        let wantToReadButton = UIButton()
        wantToReadButton.translatesAutoresizingMaskIntoConstraints = false
        wantToReadButton.setTitle(Constants.wantToReadButtonText, for: .normal)
        wantToReadButton.layer.cornerRadius = 15
        wantToReadButton.titleLabel?.font = .openSansRegular(ofSize: 15)
        wantToReadButton.contentHorizontalAlignment = .leading
//        wantToReadButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: Constants.buttonLeadingInset, bottom: 0, right: 0)
        wantToReadButton.setTitleColor(.black, for: .normal)
        wantToReadButton.backgroundColor = .label
        wantToReadButton.setImage(Constants.arrowImage, for: .normal)
//        let spacing: CGFloat = 8.0
//        wantToReadButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -spacing/2, bottom: 0, right: spacing/2)
//        wantToReadButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2, bottom: 0, right: -spacing/2)
//        wantToReadButton.setBackgroundImage(Constants.arrowImage, for: .normal)
    
        return wantToReadButton
    }()
    
    private lazy var classicBooksButton: UIButton = {
        let classicBooksButton = UIButton()
        classicBooksButton.translatesAutoresizingMaskIntoConstraints = false
        classicBooksButton.setTitle(Constants.classicBooksButtonText, for: .normal)
        classicBooksButton.titleLabel?.font = .openSansRegular(ofSize: 15)
        classicBooksButton.contentHorizontalAlignment = .leading
        classicBooksButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: Constants.buttonLeadingInset, bottom: 0, right: 0)
        classicBooksButton.layer.cornerRadius = 15
        classicBooksButton.setTitleColor(.black, for: .normal)
        classicBooksButton.backgroundColor = .label
        return classicBooksButton
    }()
    
    private lazy var readForFunButton: UIButton = {
        let readForFunButton = UIButton()
        readForFunButton.translatesAutoresizingMaskIntoConstraints = false
        readForFunButton.setTitle(Constants.readForFunButtonText, for: .normal)
        readForFunButton.backgroundColor = .label
        readForFunButton.titleLabel?.font = .openSansRegular(ofSize: 15)
        readForFunButton.contentHorizontalAlignment = .leading
        readForFunButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: Constants.buttonLeadingInset, bottom: 0, right: 0)
        readForFunButton.setTitleColor(.black, for: .normal)
        readForFunButton.layer.cornerRadius = 10
        return readForFunButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawSelf()
    }
}

private extension ListsVC {
    
    func drawSelf() {
        view.backgroundColor = .white
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(wantToReadButton)
        mainStackView.addArrangedSubview(classicBooksButton)
        mainStackView.addArrangedSubview(readForFunButton)
        let mainStackViewConsraints = setMainStackViewConstraints()
        NSLayoutConstraint.activate(mainStackViewConsraints)
    }
    
    func setMainStackViewConstraints() -> [NSLayoutConstraint] {
        let topAnchor = mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.mainStackViewTopInset)
        let leadingAnchor = mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.mainStackViewTrailingInset)
        let trailingAnchor = mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.mainStackViewLeadingInset)
        let heightAnchor = mainStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3.25)
        return [topAnchor,
                leadingAnchor,
                trailingAnchor,
                heightAnchor]
    }
}

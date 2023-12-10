//
//  BookDetailsViewController.swift
//  BookStore
//
//  Created by Alexander Altman on 06.12.2023.
//

import UIKit

final class BookDetailsViewController: UIViewController {

    //MARK: - Dependencies
    let spacing: CGFloat = 24
    let labelHeight: CGFloat = 20

    //MARK: - UI Elements

    //эти UI элементы нужно перенести на отдельную View для сохранения MVC

    private lazy var topLabel: UILabel = {
        let element = UILabel()
        element.text = "The Picture of Dorian Gray"
        element.textAlignment = .center
        element.font = UIFont.openSansBold(ofSize: 24)
        element.adjustsFontSizeToFitWidth = true
        element.numberOfLines = 0
        return element
    }()

    private lazy var mainStack: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.distribution = .fillEqually
        element.spacing = 20
        return element
    }()

    private lazy var rightStack: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.distribution = .fill
        element.alignment = .leading
        element.spacing = 10
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var leftStack: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.distribution = .equalSpacing
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var bookCover: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "mockCover")
        element.contentMode = .scaleAspectFit
        return element
    }()

    //у этих трёх лейблов тоже нужно заменить цвет текста на .label
    private lazy var authorLabel = UILabel(text1: "Author: ", text2: BookDetailsModel.authorName)
    private lazy var categoryLabel = UILabel(text1: "Category: ", text2: BookDetailsModel.category)
    private lazy var raitingLabel = UILabel(text1: "Raiting: ", text2: BookDetailsModel.raiting)

    private lazy var descriptionLabel: UILabel = {
        let element = UILabel()
        element.text = "Description:"
        element.font = UIFont.openSansBold(ofSize: 14)
        return element
    }()

    private lazy var descriptionTextView: UITextView = {
        let element = UITextView()
        element.isScrollEnabled = true
        element.text = BookDetailsModel.descriptionText
        element.font = UIFont.openSansRegular(ofSize: 14)
        element.backgroundColor = .clear

        DispatchQueue.main.async {
            element.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: false)
        }

        return element
    }()

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setStack()
        setConstraints()
    }

    //MARK: - Private Methods
    private func setupViews() {
        view.backgroundColor = UIColor.background

        view.addSubviewsTamicOff(
            topLabel,
            mainStack,
            bookCover,
            authorLabel,
            categoryLabel,
            raitingLabel,
            descriptionLabel,
            descriptionTextView
        )
    }

    private func setStack() {
        mainStack.addArrangedSubview(leftStack)
        mainStack.addArrangedSubview(rightStack)
        leftStack.addArrangedSubview(bookCover)
        rightStack.addSubview(authorLabel)
        rightStack.addSubview(categoryLabel)
        rightStack.addSubview(raitingLabel)
    }
}

//MARK: - Constraints
private extension BookDetailsViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: spacing),
            topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spacing),
            topLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -spacing),

            mainStack.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: spacing),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spacing),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -spacing),
            mainStack.heightAnchor.constraint(equalToConstant: view.bounds.height / 3),

            descriptionLabel.topAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: spacing),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spacing),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -spacing),

            descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: spacing),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spacing),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -spacing),
            descriptionTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            authorLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            categoryLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            raitingLabel.heightAnchor.constraint(equalToConstant: labelHeight),

            authorLabel.topAnchor.constraint(equalTo: rightStack.topAnchor, constant: 30),
            categoryLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 10),
            raitingLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10)
        ])
    }
}

//MARK: - Convenience Inits
extension UILabel {
    convenience init(text1: String, text2: String) {
        self.init()
        let regularFont = UIFont.openSansRegular(ofSize: 14)
        let boldFont = UIFont.openSansBold(ofSize: 14)
        let attributedText = NSMutableAttributedString(
            string: text1,
            attributes: [.font: regularFont ?? UIFont.systemFont(ofSize: 14),
                         .foregroundColor: UIColor.label])
        let categoryText = NSAttributedString(
            string: text2,
            attributes: [.font: boldFont ?? UIFont.boldSystemFont(ofSize: 14),
                         .foregroundColor: UIColor.red])
        attributedText.append(categoryText)
        self.attributedText = attributedText
    }
}

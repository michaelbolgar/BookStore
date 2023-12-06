import UIKit

class AccountVC: UIViewController {
    
    private lazy var label: UILabel = {
        let label = UILabel.makeLabel(font: .openSansBold(ofSize: 16), textColor: .customBlack)
        label.text = "Account"
        return label
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.crop.circle"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel.makeLabel(font: .openSansRegular(ofSize: 14), textColor: .customBlack)
        label.textAlignment = .left
        label.text = "Name:"
        return label
    }()
    
    private lazy var nameValueLabel: UILabel = {
        let label = UILabel.makeLabel(font: .openSansSemiBoldItalic(ofSize: 16), textColor: .customBlack)
        label.textAlignment = .left
        label.text = "John Doe"
        return label
    }()
    
    private lazy var nameStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, nameValueLabel])
        stack.alignment = .leading
        stack.axis = .horizontal
        stack.spacing = 40
        return stack
    }()
    
    private lazy var nameBackgroundView:  UIView = {
        let view = UIView()
        view.backgroundColor = .customLightGray
        view.layer.cornerRadius = 5
        view.addSubviews(nameStackView)
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .white
    }
    
    private func setupUI() {
        view.addSubviews(label,avatarImageView,nameBackgroundView)
        NSLayoutConstraint.activate([
            
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            avatarImageView.heightAnchor.constraint(equalToConstant: 120),
            avatarImageView.widthAnchor.constraint(equalToConstant: 120),
            avatarImageView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 32),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameBackgroundView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            nameBackgroundView.heightAnchor.constraint(equalToConstant: 56),
            nameBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            nameStackView.leadingAnchor.constraint(equalTo: nameBackgroundView.leadingAnchor, constant: 10),
            nameStackView.trailingAnchor.constraint(equalTo: nameBackgroundView.trailingAnchor, constant: -10),
            nameStackView.centerYAnchor.constraint(equalTo: nameBackgroundView.centerYAnchor)
            
        ])
    }
}

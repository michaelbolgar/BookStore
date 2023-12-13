import UIKit

class AccountView: UIView {
    
    //MARK: - Elements
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.crop.circle"))
        imageView.layer.cornerRadius = 60
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .black
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var accountLabel = UILabel.makeLabel(text: "Account", font: .openSansBold(ofSize: 16), textColor: .labelColors)
    
    private lazy var nameLabel = UILabel.makeLabel(text: "Name:", font: .openSansRegular(ofSize: 14), textColor: .labelColors)
    
    private lazy var nameValueLabel: UILabel = {
        let label = UILabel.makeLabel(font: .openSansSemiBoldItalic(ofSize: 16), textColor: .labelColors)
        label.text = "John Doe"
        return label
    }()
    
    private lazy var nameBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .label
        view.layer.cornerRadius = 5
        return view
    }()

    //переделать это в полноценную кнопку
    private lazy var listBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .label
        view.layer.cornerRadius = 5
        return view
    }()
    
    private lazy var myListLabel = UILabel.makeLabel(text: "My Lists", font: .openSansRegular(ofSize: 14), textColor: .labelColors)
    
    lazy var goToMyListButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "arrow.forward"), for: .normal)
        button.tintColor = .elements
        return button
    }()
    
    lazy var modeSwitch: UIButton = {
        let modeSwitch = UIButton()
        modeSwitch.setBackgroundImage(UIImage(systemName: "sun.min.fill"), for: .normal)
        modeSwitch.tintColor = .elements
        return modeSwitch
    }()
    
    //MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    //MARK: - Setup UI
    
    private func setupUI() {
        let offset: CGFloat = 20
        addSubviewsTamicOff(accountLabel, avatarImageView, nameBackgroundView,listBackgroundView, modeSwitch)
        nameBackgroundView.addSubviewsTamicOff(nameLabel, nameValueLabel)
        listBackgroundView.addSubviewsTamicOff(myListLabel, goToMyListButton)
        
        NSLayoutConstraint.activate([
            accountLabel.topAnchor.constraint(equalTo: topAnchor, constant: offset),
            accountLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            avatarImageView.heightAnchor.constraint(equalToConstant: 120),
            avatarImageView.widthAnchor.constraint(equalToConstant: 120),
            avatarImageView.topAnchor.constraint(equalTo: accountLabel.bottomAnchor, constant: 32),
            avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            nameBackgroundView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: offset),
            nameBackgroundView.heightAnchor.constraint(equalToConstant: 56),
            nameBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: offset),
            nameBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -offset),
            
            nameLabel.leadingAnchor.constraint(equalTo: nameBackgroundView.leadingAnchor, constant: 12),
            nameLabel.centerYAnchor.constraint(equalTo: nameBackgroundView.centerYAnchor),
            
            nameValueLabel.centerYAnchor.constraint(equalTo: nameBackgroundView.centerYAnchor),
            nameValueLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: offset),
            nameValueLabel.trailingAnchor.constraint(greaterThanOrEqualTo: nameBackgroundView.trailingAnchor, constant: -12),
            
            listBackgroundView.topAnchor.constraint(equalTo: nameValueLabel.bottomAnchor, constant: 25),
            listBackgroundView.heightAnchor.constraint(equalToConstant: 56),
            listBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: offset),
            listBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -offset),
            
            myListLabel.leadingAnchor.constraint(equalTo: listBackgroundView.leadingAnchor, constant: 12),
            myListLabel.centerYAnchor.constraint(equalTo: listBackgroundView.centerYAnchor),
            
            goToMyListButton.trailingAnchor.constraint(equalTo: listBackgroundView.trailingAnchor, constant: -offset),
            goToMyListButton.centerYAnchor.constraint(equalTo: listBackgroundView.centerYAnchor),
            goToMyListButton.widthAnchor.constraint(equalToConstant: 16),
            goToMyListButton.heightAnchor.constraint(equalToConstant: 16),
            
            modeSwitch.widthAnchor.constraint(equalToConstant: 34),
            modeSwitch.heightAnchor.constraint(equalToConstant: 34),
            modeSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -offset),
            modeSwitch.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
        ])
    }
}

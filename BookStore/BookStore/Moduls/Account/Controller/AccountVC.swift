import UIKit

class AccountVC: UIViewController {
    
    //MARK: - Elements
    private let avatarUserDefaultsKey = "UserAvatar"
    
    private lazy var label: UILabel = {
        let label = UILabel.makeLabel(font: .openSansBold(ofSize: 16), textColor: .labelColors)
        label.text = "Account"
        return label
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.crop.circle"))
        imageView.layer.cornerRadius = 60
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .black
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeAvatar)))
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel.makeLabel(font: .openSansRegular(ofSize: 14), textColor: .labelColors)
        label.textAlignment = .left
        label.text = "Name:"
        return label
    }()
    
    private lazy var nameValueLabel: UILabel = {
        let label = UILabel.makeLabel(font: .openSansSemiBoldItalic(ofSize: 16), textColor: .labelColors)
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
        view.backgroundColor = .label
        view.layer.cornerRadius = 5
        view.addSubviewsTamicOff(nameStackView)
        return view
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadAvatarFromUserDefaults()
        view.backgroundColor = .background
    }
    
    //MARK: - Private Methods
    @objc private func changeAvatar() {
        print ("вызвался")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func loadAvatarFromUserDefaults() {
        if let savedImageData = UserDefaults.standard.object(forKey: avatarUserDefaultsKey) as? Data,
           let savedImage = UIImage(data: savedImageData) {
            avatarImageView.image = savedImage
        } else {
            avatarImageView.image = UIImage(systemName: "person.crop.circle")
        }
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        view.addSubviewsTamicOff(label,avatarImageView,nameBackgroundView)
        let offset: CGFloat = 20
        NSLayoutConstraint.activate([
            
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: offset),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            avatarImageView.heightAnchor.constraint(equalToConstant: 120),
            avatarImageView.widthAnchor.constraint(equalToConstant: 120),
            avatarImageView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 32),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameBackgroundView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            nameBackgroundView.heightAnchor.constraint(equalToConstant: 56),
            nameBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset),
            nameBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -offset),
            
            nameStackView.leadingAnchor.constraint(equalTo: nameBackgroundView.leadingAnchor, constant: 10),
            nameStackView.trailingAnchor.constraint(equalTo: nameBackgroundView.trailingAnchor, constant: -10),
            nameStackView.centerYAnchor.constraint(equalTo: nameBackgroundView.centerYAnchor)
            
        ])
    }
}
// MARK: - UIImagePickerControllerDelegate
extension AccountVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            avatarImageView.image = pickedImage
            
            if let imageData = pickedImage.pngData() {
                UserDefaults.standard.set(imageData, forKey: avatarUserDefaultsKey)
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

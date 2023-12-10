import UIKit

class AccountVC: UIViewController {
    
    //MARK: - Elements
    private let accountView = AccountView()
    private let avatarUserDefaultsKey = "UserAvatar"
    private var isDarkMode = false
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        isDarkMode = UserDefaults.standard.bool(forKey: "AppDarkMode")
        setupUI()
        loadAvatarFromUserDefaults()
        view.backgroundColor = .background
    }
    
    //MARK: - Private Methods
    private func setupUI() {
        view.addSubviewsTamicOff(accountView)
        
        NSLayoutConstraint.activate([
            accountView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            accountView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            accountView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            accountView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        accountView.avatarImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeAvatar)))
        accountView.modeSwitch.addTarget(self, action: #selector(didTapModeSwitch), for: .touchUpInside)
        accountView.goToMyListButton.addTarget(self, action: #selector(didTapMyListButton), for: .touchUpInside)
        
    }
    
    private func loadAvatarFromUserDefaults() {
        if let savedImageData = UserDefaults.standard.object(forKey: avatarUserDefaultsKey) as? Data,
           let savedImage = UIImage(data: savedImageData) {
            accountView.avatarImageView.image = savedImage
        } else {
            accountView.avatarImageView.image = UIImage(systemName: "person.crop.circle")
        }
    }
    
    private func updateInterfaceStyle() {
        overrideUserInterfaceStyle = isDarkMode ? .dark : .light
    }
    
    //MARK: - Objc Methods
    @objc private func changeAvatar() {
        print("вызвался")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc private func didTapModeSwitch() {
        isDarkMode.toggle()
        updateInterfaceStyle()
        UserDefaults.standard.set(isDarkMode, forKey: "AppDarkMode")
        
        if #available(iOS 13.0, *) {
            let selectedTheme: UIUserInterfaceStyle = isDarkMode ? .dark : .light
            UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .forEach { window in
                    window.overrideUserInterfaceStyle = selectedTheme
                }
        }
    }
    
    @objc private func didTapMyListButton() {
        print("Go to my list")
    }
}

// MARK: - UIImagePickerControllerDelegate
extension AccountVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.accountView.avatarImageView.image = pickedImage
            
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



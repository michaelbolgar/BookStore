import UIKit

class CategoriesVC: UIViewController {
    
    //MARK: - CreateUIElements, private constans
    private let categoriesView = CategoriesView()
    var books = [CategoryCollection.Work]()
    var categoryModel = CategoriesModel()

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        categoriesView.collectionView.delegate = self
        categoriesView.collectionView.dataSource = self
        view = categoriesView
        navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - PrivateMethods
    private func presentIndicator() -> UIActivityIndicatorView {
        let activityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicatorView.frame = self.view.bounds
        activityIndicatorView.center = self.view.center
        activityIndicatorView.backgroundColor = .clear.withAlphaComponent(0.2)
        self.view.addSubview(activityIndicatorView)
        return activityIndicatorView
    }
    
    private func getBooksFromNetwork(with category: Categories, categoryString: String) {
        let activityIndicator = presentIndicator()
        activityIndicator.startAnimating()
        NetworkingManager.instance.getCategoryCollection (for: category) { result in
            switch result {
            case .success(let subjectResponse):
                self.books = subjectResponse.first?.works ?? [CategoryCollection.Work]()
                DispatchQueue.main.async {
                    let vc = LikesVC()
                    vc.books = self.books
                    vc.genre = categoryString
                    vc.previosVC = categoryString
                    activityIndicator.stopAnimating()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print("Ошибка при получении категорий: \(error)")
            }
        }
    }
    
    private func presentAlertErorNotCategoryList() {
        
    }
    
}
//MARK: - extensions CategoriesVC
extension CategoriesVC: UICollectionViewDelegate,
                        UICollectionViewDataSource,
                        UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return categoryModel.categoriesName.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.self.description(),
                                                            for: indexPath) as? CategoriesCell
        else {
            return UICollectionViewCell()
        }
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 5
        cell.genre.text = categoryModel.categoriesName[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categoryModel.category[categoryModel.categoriesName[indexPath.item]]
        getBooksFromNetwork(with: category ?? .art,
                            categoryString: categoryModel.categoriesName[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                           withReuseIdentifier: CategoriesHeader.self.description(),
                                                                           for: indexPath) as? CategoriesHeader
        else {
            return UICollectionReusableView()
        }
        header.headerLabel.text = "Categories"
        header.headerLabel.font = UIFont.openSansRegular(ofSize: 20)
        return header
    }
}




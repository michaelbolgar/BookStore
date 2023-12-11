import UIKit

class CategoriesVC: UIViewController {
    
    //MARK: - CreateUIElements, private constans
    private let categoriesView = CategoriesView()

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        categoriesView.collectionView.delegate = self
        categoriesView.collectionView.dataSource = self
        view = categoriesView

        //get category collection example
        NetworkingManager.instance.getCategoryCollection (for: .love) { result in
            switch result {
            case .success(let subjectResponse):
                print(subjectResponse)
//                    print(subjectResponse[0].works)

//                for book in subjectResponse[0].works {
//                    if let title = book.title {
//                        print(title)
//                    }
//                }

            case .failure(let error):
                print("Ошибка при получении категорий: \(error)")
            }
        }
    }
}
//MARK: - extensions CategoriesVC
extension CategoriesVC: UICollectionViewDelegate,
                        UICollectionViewDataSource,
                        UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 20
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
        return cell
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




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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.self.description(),
                                                      for: indexPath) as! CategoriesCell
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: CategoriesHeader.self.description(),
                                                                     for: indexPath) as! CategoriesHeader
        header.headerLabel.text = "Categories"
        header.headerLabel.font = UIFont.openSansRegular(ofSize: 20)
        return header
    }
}




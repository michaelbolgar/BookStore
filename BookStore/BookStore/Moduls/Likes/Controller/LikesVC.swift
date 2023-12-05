import UIKit

class LikesVC: UIViewController {
    
    //MARK: - createUIElements, constans
    private let likesView = LikesView()
    private let widthItem = 320
    private let heightItem = 140
    private let spacingForSection: CGFloat = 16
    
    //MARK: - initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        likesView.collectionView.delegate = self
        likesView.collectionView.dataSource = self
        view = likesView
    }
}
    //MARK: - extensions LikesVC
extension LikesVC: UICollectionViewDelegate,
                   UICollectionViewDataSource,
                   UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikesCell.self.description(),
                                                      for: indexPath) as! LikesCell
        cell.clipsToBounds = true
        cell.backgroundColor = .black
        cell.layer.cornerRadius = 8
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: widthItem, height: heightItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacingForSection
    }
}

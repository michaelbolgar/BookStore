import UIKit

class LikesVC: UIViewController {
    
    //MARK: - CreateUIElements, private constans
    private let likesView = LikesView()
    private let widthItem = 320
    private let heightItem = 140
    private let spacingForSection: CGFloat = 16
    var books = [CategoryCollection.Work]()
    var genre: String?
    var previosVC = "Likes"
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        likesView.collectionView.delegate = self
        likesView.collectionView.dataSource = self
        view = likesView
        setNavigationItem()
        presentEmptyViewOrNot()
    }
    
    //MARK: - PrivateMethods
    private func setNavigationItem() {
        navigationController?.navigationBar.isHidden = false
        if previosVC != "Likes" {
            setNavigationBarWithBlackColor(title: genre ?? "Love")
        } else {
            setNavigationBarWithBlackColor(title: previosVC)
        }
    }
    
    private func presentEmptyViewOrNot() {
        if books.isEmpty {
            likesView.collectionView.isHidden = true
            navigationController?.navigationBar.isHidden = true
        }
    }
}
    //MARK: - extensions LikesVC
extension LikesVC: UICollectionViewDelegate,
                   UICollectionViewDataSource,
                   UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikesCell.self.description(),
                                                            for: indexPath) as? LikesCell
        else {
            return UICollectionViewCell()
        }
        
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 8
        cell.genre.text = genre
        cell.name.text = books[indexPath.item].title
        if books[indexPath.item].authors.count > 1 {
            var authorString = ""
            for author in books[indexPath.item].authors {
                authorString.append("\(author.name ?? ""), ")
            }
            authorString.removeLast()
            authorString.removeLast()
            cell.author.text = authorString
        } else {
            cell.author.text = books[indexPath.item].authors.first?.name
        }
        cell.closeButton.isHidden = false ? previosVC != "Likes" : true
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

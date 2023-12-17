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
    var url = [URL]()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        likesView.collectionView.delegate = self
        likesView.collectionView.dataSource = self
        view = likesView
        url = getUrlImagesForBooks()
        setNavigationItem()
        presentEmptyViewOrNot()
    }
    
    //MARK: - PrivateMethods
    //Метод для понимания откуда пришли, если пришли с экрана категорий то previosVC != "Likes", если нажали на лайк в таббаре, то ставим Лайки в названии
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
    
    private func getUrlImagesForBooks() -> [URL] {
        var covers = [Int]()
        for cov in books {
            covers.append(cov.cover_id ?? 12818862)
        }
        var imagesURL = [URL]()
        for cover in covers {
            imagesURL.append(URL(string: "https://covers.openlibrary.org/b/id/\(cover)-M.jpg")!)
        }
        return imagesURL
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
        NetworkingManager.instance.loadImage(from: url[indexPath.item]) { image in
            DispatchQueue.main.async {
                cell.image.image = image
            }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = BookDetailsViewController()
        NetworkingManager.instance.loadImage(from: url[indexPath.item]) { image in
            DispatchQueue.main.async {
                var authorString = ""
                if self.books[indexPath.item].authors.count > 1 {
                    for author in self.books[indexPath.item].authors {
                        authorString.append("\(author.name ?? ""), ")
                    }
                    authorString.removeLast()
                    authorString.removeLast()
                } else {
                    authorString = self.books[indexPath.item].authors.first?.name ?? ""
                }
                
                NetworkingManager.instance.getBookDetails(for: self.books[indexPath.item].key ?? "/works/OL82586W") { result in
                    DispatchQueue.main.async {
                        
                        switch result {
                        case .success(let bookDetails):
                            let description = bookDetails.description?.value ?? "No description"
                            let rating = bookDetails.rating?.summary?.average
                            print("Ratins is \(rating)")
                            let booksModel = BookDetailsModel(key: self.books[indexPath.item].key ?? "",
                                                              image: image ?? UIImage(),
                                                              title: self.books[indexPath.item].title ?? "",
                                                              authorName: authorString,
                                                              hasFullText: self.books[indexPath.item].has_fulltext ?? false,
                                                              ia: self.books[indexPath.item].ia ?? "",
                                                              category: self.genre ?? "no genre",
                                                              rating: rating,
                                                              descriptionText: description)
                            vc.book = booksModel
                            
//                            self.navigationController?.pushViewController(vc, animated: true)
                        case .failure(let error):
                            let booksModel = BookDetailsModel(key: self.books[indexPath.item].key ?? "",
                                                              image: image ?? UIImage(),
                                                              title: self.books[indexPath.item].title ?? "",
                                                              authorName: authorString,
                                                              hasFullText: self.books[indexPath.item].has_fulltext ?? false,
                                                              ia: self.books[indexPath.item].ia ?? "",
                                                              category: self.genre ?? "no genre",
                                                              rating:  0.04,
                                                              descriptionText: "no description")
                            
                            vc.book = booksModel
                            
                            print("Error getting book details: \(error.localizedDescription)")
                        }
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }


            }
        }
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

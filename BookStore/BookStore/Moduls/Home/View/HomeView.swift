import UIKit
import SnapKit

final class HomeView: UIView {
    
    //MARK: UI Elements
    
    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .background
        collectionView.bounces = false
        return collectionView
    }()
    
    // MARK: - Private Properties
    
    private let sections = HomeModel.shared.pageData
    private let networkManager = NetworkingManager.instance
    private var trendingBooks: [(book: TrendingBooks.Book, image: UIImage?)] = []
    private var works: [(work: CategoryCollection.Work, image: UIImage?)] = []
    var selectedSegment: TrendingPeriod = .weekly {
       didSet {
           print("Selected segment changed to \(selectedSegment)")
           self.collectionView.reloadData()
       }
    }
    
    private var spinnerView = UIActivityIndicatorView()
    
    // MARK: - Set Views
    
    func setViews() {
        self.backgroundColor = .background
        
        self.addSubview(collectionView)
        
        fetchTrendingBooks()
        
        buttonPressed(selectedSegment: selectedSegment)
        
        fetchCategoryCollection()
        
        showSpinner(in: self)
        
        collectionView.register(TopBooksViewCell.self,
                                forCellWithReuseIdentifier: "TopBooksCollectionViewCell")
        collectionView.register(RecentBooksViewCell.self,
                                forCellWithReuseIdentifier: "RecentBooksViewCell")
        collectionView.register(HeaderSupplementaryView.self,
                                forSupplementaryViewOfKind: "headerItem",
                                withReuseIdentifier: "HeaderSupplementaryView")
        collectionView.register(CustomSegmentedControlReusableView.self,
                                forSupplementaryViewOfKind: "segmentedControl",
                                withReuseIdentifier: "SegmentedControl")
        
        collectionView.collectionViewLayout = createLayout()
    }
    
    // MARK: - Setup Constraints
    
    func setupConstraints() {
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
        
        spinnerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    // MARK: - Set Delegates
    
    func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension UIStackView {
    convenience init(spacing: CGFloat, axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment) {
        self.init()
        self.spacing = spacing
        self.axis = axis
        self.alignment = alignment
    }
}

// MARK: - Create Layout

private extension HomeView {
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self = self else { return nil }
            let section = self.sections[sectionIndex]
            switch section {
                
            case .topBooks(_):
                return self.createTopBookSection()
            case .recentBooks(_):
                return self.createBottomBookSection()
            }
        }
    }
    
    private func createLayoutSection(group: NSCollectionLayoutGroup,
                                     behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior,
                                     interGroupSpacing: CGFloat,
                                     supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem],
                                     contentInsets: Bool) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = behavior
        section.interGroupSpacing = interGroupSpacing
        section.boundarySupplementaryItems = supplementaryItems
        section.supplementariesFollowContentInsets = contentInsets
        return section
    }
    
    private func createTopBookSection() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(0.9)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.5),
                                                                         heightDimension: .fractionalHeight(0.4)),
                                                       subitems: [item])
        
        
        let segmentedControlItem = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                               heightDimension: .estimated(100)),
            elementKind: "segmentedControl",
            alignment: .top
        )
        
        let section = createLayoutSection(group: group,
                                          behavior: .continuous,
                                          interGroupSpacing: 10,
                                          supplementaryItems: [segmentedControlItem],
                                          contentInsets: true)
        section.contentInsets = .init(top: 0, leading: 19, bottom: 0, trailing: 0)
        
        return section
    }
    
    private func createBottomBookSection() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(0.9)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.5),
                                                                         heightDimension: .fractionalHeight(0.4)),
                                                       subitems: [item])
        
        let section = createLayoutSection(group: group,
                                          behavior: .continuous,
                                          interGroupSpacing: 10,
                                          supplementaryItems: [supplementaryHeaderItem()],
                                          contentInsets: true)
        section.contentInsets = .init(top: 0, leading: 19, bottom: 0, trailing: 0)
        
        return section
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                heightDimension: .estimated(50)),
              elementKind: "headerItem",
              alignment: .top)
    }

}

// MARK: - UICollectionViewDelegate

extension HomeView: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource

extension HomeView: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        trendingBooks.prefix(10).count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
            
        case .topBooks(_):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopBooksCollectionViewCell", for: indexPath) as? TopBooksViewCell
            else {
                return UICollectionViewCell()
            }

            //приложение вылетает, если начать менять запрос на top books по разным периодам. Нужно искать баг
            let bookWithImage = trendingBooks[indexPath.row]
            let book = bookWithImage.book
            let image = bookWithImage.image
            cell.configureCell(book: book, image: image)
            
            return cell
            
        case .recentBooks(_):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentBooksViewCell", for: indexPath) as? RecentBooksViewCell
            else {
                return UICollectionViewCell()
            }
            let work = works[indexPath.row]
            cell.configureCell(work: work)
            
            return cell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case "headerItem":
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                            withReuseIdentifier: "HeaderSupplementaryView",
                                                                            for: indexPath) as? HeaderSupplementaryView {
                header.configureHeader(categoryName: sections[indexPath.section].title)
                return header
                
            } else {
                return UICollectionReusableView()
            }
            
        case "segmentedControl":
            if let segmentedControl = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                      withReuseIdentifier: "SegmentedControl",
                                                                                      for: indexPath) as? CustomSegmentedControlReusableView {
                segmentedControl.segmentedControl.delegate = self
                return segmentedControl
            } else {
                return UICollectionReusableView()
            }
            
        default:
            return UICollectionReusableView()
        }
    }
    
    // MARK: - Networking
    
    private func fetchTrendingBooks() {
        print("Fetching trending books for period: \(selectedSegment)")
        
        networkManager.getTrendingBooks(for: selectedSegment) { [weak self] result in
            switch result {
            case .success(let trendingBooks):
                for bookWithCoverURL in trendingBooks {
                    let coverURL = bookWithCoverURL.1
                    NetworkingManager.instance.loadImage(from: coverURL) { image in
                        DispatchQueue.main.async {
                            self?.trendingBooks.append((bookWithCoverURL.0, image))
                            self?.spinnerView.stopAnimating()
                            self?.collectionView.reloadData()
                            
                        }
                    }
                }
            case .failure(let error):
                print("Ошибка при получении недельной подборки: \(error)")
            }
        }
    }

    //переименовать функцию
    private func fetchCategoryCollection() {
        networkManager.getCategoryCollection(for: .fiction) { [weak self] result in
            switch result {
            case .success(let categoryCollection):
                if let firstCategory = categoryCollection.first {
                    for work in firstCategory.works {
                        if let coverID = work.cover_id {
                            let coverURL = URL(string: "https://covers.openlibrary.org/b/id/\(coverID)-M.jpg")!
                            self?.networkManager.loadImage(from: coverURL) { image in
                                DispatchQueue.main.async {
                                    self?.works.append((work, image))
                                    self?.collectionView.reloadData()
                                }
                            }
                        }
                    }
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    // MARK: - Spinner
    
    private func showSpinner(in view: UIView) {
        spinnerView = UIActivityIndicatorView(style: .large)
        spinnerView.color = .black
        spinnerView.startAnimating()
        spinnerView.hidesWhenStopped = true
        
        view.addSubview(spinnerView)
    }
    
    func updateCollection(for selectedSegment: TrendingPeriod) {
      fetchTrendingBooks()
    }
    
 
}

// MARK: - SegmentedControl delegate

extension HomeView: CustomSegmentedControlDelegate {
   func buttonPressed(selectedSegment: TrendingPeriod) {
       self.selectedSegment = selectedSegment
       trendingBooks.removeAll()
       fetchTrendingBooks()
    

   }
}

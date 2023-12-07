import UIKit
import SnapKit

final class HomeView: UIView {
    //MARK: UI Elements
    
    private let mainStackView = UIStackView(spacing: 10, axis: .vertical, alignment: .leading)
    
    private let topBooksStackView = UIStackView(spacing: 0, axis: .horizontal, alignment: .fill)
    private let topBooksTitleLabel = UILabel.makeLabel(
        text: "Top Books",
        font: .openSansBold(ofSize: 20),
        textColor: .elements
    )
    private let buttonTitles: [String] = ["This Week", "This Month", "This Year"]
    private lazy var segmentedControl: CustomSegmentedControl = CustomSegmentedControl(buttonTitles: buttonTitles)
    private let centeredTitle: UILabel = UILabel()
    
    private let seeMoreButton = UIButton.makeButton(text: "see more", buttonColor: .clear, tintColor: .elements, borderWidth: 0)
    
    private let topButtonsStackView = UIStackView(spacing: 0, axis: .horizontal, alignment: .center)
    
    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .background
        collectionView.bounces = false
        return collectionView
    }()
    
    // MARK: - Private Properties
    private let sections = MockData.shared.pageData
    
    //MARK: View Lifecycle Methods
    
    
    // MARK: - Actions
    
    @objc func seeMoreButtonTapped() {
        UIView.animate(withDuration: 0.3, animations: {
            self.seeMoreButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: { _ in
            UIView.animate(withDuration: 0.3, animations: {
                self.seeMoreButton.transform = CGAffineTransform.identity
            })
        })
    }
    
    // MARK: - Set Views
    
    func setViews() {
        seeMoreButton.addTarget(self, action: #selector(seeMoreButtonTapped), for: .touchUpInside)
        
        self.backgroundColor = .background
        
        self.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(collectionView)
        
        mainStackView.addArrangedSubview(topBooksStackView)
        mainStackView.addArrangedSubview(topButtonsStackView)
        mainStackView.addArrangedSubview(collectionView)
        collectionView.register(TopBooksViewCell.self,
                                forCellWithReuseIdentifier: "TopBooksCollectionViewCell")
        collectionView.register(RecentBooksViewCell.self,
                                forCellWithReuseIdentifier: "RecentBooksViewCell")
        collectionView.register(HeaderSupplementaryView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "HeaderSupplementaryView")
        
        collectionView.collectionViewLayout = createLayout()
        
        topBooksStackView.addArrangedSubview(topBooksTitleLabel)
        topBooksStackView.addArrangedSubview(seeMoreButton)
        
        topButtonsStackView.addArrangedSubview(segmentedControl)
        topButtonsStackView.addArrangedSubview(centeredTitle)
        
    }
    
    // MARK: - Setup Constraints
    
    func setupConstraints() {
        mainStackView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
            make.left.equalToSuperview().inset(19)
        }
        
        topBooksStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(100)
        }
        
        seeMoreButton.snp.makeConstraints { make in
            make.width.equalTo(62)
            make.height.equalTo(20)
        }
        
        topButtonsStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(100)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
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

extension HomeView {
    
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
                                                            heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.5),
                                                                         heightDimension: .fractionalHeight(0.4)),
                                                       subitems: [item])
        
        let section = createLayoutSection(group: group,
                                          behavior: .continuous,
                                          interGroupSpacing: 10,
                                          supplementaryItems: [],
                                          contentInsets: true)
        section.contentInsets = .init(top: 0, leading: 19, bottom: 0, trailing: 0)
        
        return section
    }
    
    private func createBottomBookSection() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(1)))
        
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
              elementKind: UICollectionView.elementKindSectionHeader,
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
        sections[section].count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
            
        case .topBooks(let topBook):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopBooksCollectionViewCell", for: indexPath) as? TopBooksViewCell
            else {
                return UICollectionViewCell()
            }
            cell.configureCell(imageName: topBook[indexPath.row].image)
            return cell
            
        case .recentBooks(let recentBook):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentBooksViewCell", for: indexPath) as? RecentBooksViewCell
            else {
                return UICollectionViewCell()
            }
            cell.configureCell(imageName: recentBook[indexPath.row].image)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                            withReuseIdentifier: "HeaderSupplementaryView",
                                                                            for: indexPath) as? HeaderSupplementaryView {
                header.configureHeader(categoryName: sections[indexPath.section].title)
                return header
            } else {
                return UICollectionReusableView()
            }
            
        default:
            return UICollectionReusableView()
        }
    }
    
    
}

// MARK: SegmentedControl delegate
extension HomeView: CustomSegmentedControlDelegate {
    func buttonPressed(buttonTitlesIndex: Int, title: String?) {
        centeredTitle.text = "\(buttonTitles[buttonTitlesIndex]) selected"
    }
}

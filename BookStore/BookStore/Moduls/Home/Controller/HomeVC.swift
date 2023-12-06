import UIKit
import SnapKit

final class HomeVC: UIViewController {
    
    //MARK: UI Elements
    
    private let mainStackView = UIStackView(spacing: 10, axis: .vertical, alignment: .leading)
    
    private let topBooksStackView = UIStackView(spacing: 0, axis: .horizontal, alignment: .fill)
    private let topBooksTitleLabel = UILabel.makeLabel(
        text: "Top Books",
        font: .openSansBold(ofSize: 20),
        textColor: .black
    )
    private let seeMoreButton = UIButton.makeButton(text: "see more", buttonColor: .clear, tintColor: .black, borderWidth: 0)
    
    private let topButtonsStackView = UIStackView(spacing: 10, axis: .horizontal, alignment: .center)
    private let weekButton = UIButton.makeButton(text: "This Week", buttonColor: .white, tintColor: .black, borderWidth: 1.2)
    private let monthButton = UIButton.makeButton(text: "This Month", buttonColor: .white, tintColor: .black, borderWidth: 1.2)
    private let yearButton = UIButton.makeButton(text: "This Year", buttonColor: .white, tintColor: .black, borderWidth: 1.2)
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        setupConstraints()
        setDelegates()
        
        seeMoreButton.addTarget(self, action: #selector(seeMoreButtonTapped), for: .touchUpInside)
    }
    
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
    
    private func setViews() {
        
        view.backgroundColor = UIColor.background
        
        view.addSubview(mainStackView)
        
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
        
        topButtonsStackView.addArrangedSubview(weekButton)
        topButtonsStackView.addArrangedSubview(monthButton)
        topButtonsStackView.addArrangedSubview(yearButton)
        
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        mainStackView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
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
        
        weekButton.snp.makeConstraints { make in
            make.width.equalTo(79)
            make.height.equalTo(32)
            
        }
        
        monthButton.snp.makeConstraints { make in
            make.width.equalTo(93)
            make.height.equalTo(32)
        }
        
        yearButton.snp.makeConstraints { make in
            make.width.equalTo(79)
            make.height.equalTo(32)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    // MARK: - Set Delegates
    
    private func setDelegates() {
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

extension HomeVC {
    
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

extension HomeVC: UICollectionViewDelegate {
    
}
// MARK: - UICollectionViewDataSource

extension HomeVC: UICollectionViewDataSource {
    
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


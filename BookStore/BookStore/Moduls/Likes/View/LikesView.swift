import UIKit
import SnapKit

class LikesView: UIView {
    
    //MARK: - Create UIElements
    var collectionView: UICollectionView!
    var emptyLabel = UILabel.makeMultiLineLabel(font: UIFont.openSansRegular(ofSize: 32),
                                                textColor: UIColor.customBlack,
                                                numberOfLines: 2)
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCollectionView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - PrivateMethods
    private func configureCollectionView() {
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.register(
            LikesCell.self,
            forCellWithReuseIdentifier: LikesCell.self.description())
        collectionView.backgroundColor = .background
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.text = "You don't have any favorite books yet"
        backgroundColor = .background
        addSubview(emptyLabel)
        addSubview(collectionView)
    }
    
    
    
    private func setConstraints() {
        emptyLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

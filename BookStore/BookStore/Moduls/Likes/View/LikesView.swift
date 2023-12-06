import UIKit
import SnapKit

class LikesView: UIView {
    
    //MARK: - Create UIElements
    var collectionView: UICollectionView!
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.register(
            LikesCell.self,
            forCellWithReuseIdentifier: LikesCell.self.description())
        configureCollectionView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - PrivateMethods
    private func configureCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
    }
    
    private func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

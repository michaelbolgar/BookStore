import UIKit
import SnapKit

final class ListView: UIView {

    // MARK: UI Elements

    lazy var tableView: UITableView = {
        $0.backgroundColor = .clear
        $0.sectionHeaderHeight = 0
        $0.estimatedRowHeight = 50
        $0.rowHeight = 50
        return $0
    }(UITableView())

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: Private Methods

    func setupUI() {
        self.backgroundColor = .background
        self.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.bottom.equalToSuperview().inset(50)
        }
    }
}

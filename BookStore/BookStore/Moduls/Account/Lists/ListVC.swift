import UIKit
import SnapKit

class ListVC: UIViewController {

    // MARK: UI Elements

    let listView = ListView()

    // MARK: Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: Private Methods

    private func setupView() {
        view.addSubview(listView)
        listView.setupUI()

        listView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func configure() {
        listView.tableView.dataSource = self
        listView.tableView.delegate = self
        listView.tableView.register(ListCellModel.self, forCellReuseIdentifier: ListCellModel.identifier)
    }
}

// MARK: Extensions

extension ListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListCellModel.identifier, for: indexPath) as? ListCellModel else {
            fatalError("Error")
        }
        return cell
    }
}

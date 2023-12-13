import UIKit

protocol ListCellModelDelegate: AnyObject {
}

final class ListCellModel: UITableViewCell {

    var delegate: ListCellModelDelegate?

    // MARK: UI Elements

    private lazy var wantReadButton = UIButton.makeButton(text: "Want to read", buttonColor: .customLightGray, tintColor: .customBlack, borderWidth: 0)

    // MARK: Init

//    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupCell()
////        cellSetup(artist: artist ?? Artist(artistName: "", artistBio: "", artistImage: UIImage()))
//    }

    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Default Methods

    override func prepareForReuse() {
        super.prepareForReuse()
        //
    }

    // MARK: Private Methods

    private func setupCell() {

        contentView.backgroundColor = .blue
        contentView.layer.cornerRadius = 5

    }
}

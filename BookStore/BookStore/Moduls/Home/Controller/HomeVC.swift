import UIKit
import SnapKit

final class HomeVC: UIViewController {

    private let homeView = HomeView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background

        view.addSubview(homeView)

        setupConstraints()

        homeView.setViews()
        homeView.setupConstraints()
        homeView.setDelegates()

        Task {
            do {
                let result = try await fetchData()
                DispatchQueue.main.async {
                    print (result)
                }
            } catch {
                print ("Произошла ошибка")
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setupConstraints() {
        homeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }

    private func fetchData() async {

        do {
            let categoryList = try await NetworkingManager.instance.getCategories(for: "horror")

            // Теперь у вас есть доступ к свойству categories в categoryList
            let categories = categoryList.categories

            // Пример использования данных
            for (category, books) in categories {
                print("Категория: \(category)")

                for book in books {
                    print("Ключ: \(book.key ?? "no key")")
                    print("Название: \(book.title ?? "no title")")
                    print("-----")
                }
            }
        } catch {
            print("Ошибка при получении категорий: \(error)")
        }
    }
}

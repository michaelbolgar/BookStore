import UIKit

public class NetworkingManager {

    var urlEndpoints = [("&mode=everything",false),
                       ("&sort=editions&mode=everything",false),
                       ("&sort=old&mode=everything",false),
                       ("&sort=new&mode=everything",false),
                       ("https://openlibrary.org/search.json?title=", true),
                       ("https://openlibrary.org/search.json?author=", true)]
    
    func importJson(url: String, completion: @escaping (BookObject) -> Void) {

        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
        guard let data = data else { return }
   
            do {
                let object = try JSONDecoder().decode(BookObject.self, from: data)
                DispatchQueue.main.async {
                    completion(object)
                }
            } catch {
                print(error)
            }
        }).resume()
    }
    
    func getUrl(rawUrl: String) -> String {
        let url = rawUrl.replacingOccurrences(of: " ", with: "+")
        return url
    }
    
    var timer: Timer?
    var searchCompletion: ((BookObject) -> Void)?

    public func searchBooks(keyword: String, emptyCompletion: () -> Void, searchCompletion: @escaping (BookObject) -> Void) {
        timer?.invalidate()
        self.searchCompletion = searchCompletion
        if keyword.isEmpty {
            emptyCompletion()
            return
        }
        var url = "https://openlibrary.org/search.json?q=" + "\(keyword)"

        for (i,c) in urlEndpoints.enumerated(){
            if(UserDefaults.standard.bool(forKey: "\(i)") == true){
                if(c.1 == false){
                    url = url + c.0
                }else{
                    url = c.0 + "\(keyword)"
                }
            }
        }
        let passData = (url: url, completion: searchCompletion)
        timer = Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(startSearching), userInfo: url, repeats: false)
    }
    
    @objc func startSearching() {
        let url = timer!.userInfo as! String
        let finalUrl = getUrl(rawUrl: url)
        guard let completion = searchCompletion else { return }
        importJson(url: finalUrl, completion: completion)
    }
}

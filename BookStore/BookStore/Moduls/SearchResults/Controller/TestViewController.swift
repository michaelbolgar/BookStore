//
//  TestViewController.swift
//  BookStore
//
//  Created by Anna Zaitsava on 16.12.23.
//

import UIKit

class TestViewController: UIViewController {
    
    var search  = SearchBarVC()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        setupUI()
    }
    
    private func setupUI() {
        view.addSubviewsTamicOff(search)
        
        let offset: CGFloat = 20
        
        NSLayoutConstraint.activate([
            
            search.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: offset),
            search.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset),
            search.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -offset),
            search.heightAnchor.constraint(equalToConstant: 56),
            
        ])
    }
}
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



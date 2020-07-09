//
//  ViewController.swift
//  UIKitMoviesApp
//
//  Created by James Rochabrun on 7/6/20.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let filterList = FilteredList([Movie(id: 0, title: "Rocky")],
                                      filterBy: \.query) { p in true }
            rowContent: { row, element in
                row.item = element
                return row
            }
        view.addSubview(filterList)
        filterList.translatesAutoresizingMaskIntoConstraints = false

        filterList.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        filterList.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        filterList.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        filterList.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

struct Movie: Searchable {
    var id: Int
    let title: String
}

extension Movie {
    
    var query: String {
        title
    }
}

final class MovieCell: GenericCell<Movie> {
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupSubViews() {
        contentView.addSubview(label)
        label.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    override func setupWithItem(_ item: Movie) {
        label.text = item.title
    }
}

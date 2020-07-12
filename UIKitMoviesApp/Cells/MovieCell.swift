//
//  MovieCell.swift
//  UIKitMoviesApp
//
//  Created by James Rochabrun on 7/9/20.
//

import UIKit

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

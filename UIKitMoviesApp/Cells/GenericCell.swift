//
//  GenericCell.swift
//  UIKitMoviesApp
//
//  Created by James Rochabrun on 7/6/20.
//

import UIKit

class GenericCell<Element>: UITableViewCell {
    
    var item: Element? {
        didSet {
            guard let item = item else { return }
            setupWithItem(item)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubViews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupSubViews()
    }
    
    func setupSubViews() {
    }
    
    func setupWithItem(_ item: Element) {
    }
}

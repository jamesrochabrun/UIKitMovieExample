//
//  FilteredList.swift
//  UIKitMoviesApp
//
//  Created by James Rochabrun on 7/6/20.
//

import UIKit

final class FilteredList<Element, FilterKey, RowContent>: UIView
    where Element: Searchable, RowContent: GenericCell<Element> {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RowContent.self)
        tableView.backgroundColor = nil
        tableView.backgroundView = nil
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        return tableView
    }()
    
    private var filterKey: KeyPath<Element, FilterKey>?
    private var isIncluded: ((FilterKey) -> Bool)?
    private var rowContent: ((UITableView, Element) -> RowContent)?
    
    convenience init(
        _ items: [Element],
        filterBy key: KeyPath<Element, FilterKey>,
        isIncluded: @escaping (FilterKey) -> Bool,
        rowContent: @escaping (UITableView, Element) -> RowContent
    ) {
        self.init(frame: .zero)
        self.filterKey = key
        self.isIncluded = isIncluded
        self.rowContent = rowContent
        self.setupDataSource(items, rowContent: rowContent)
    }
    
    private var dataSource: GenericDataSource<RowContent, Element>?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func setupDataSource(_ items: [Element],
                                 rowContent: @escaping (UITableView, Element) -> RowContent) {
        
        dataSource = GenericDataSource(models: items, configureCell: rowContent)
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
}

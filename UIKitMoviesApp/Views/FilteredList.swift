//
//  FilteredList.swift
//  UIKitMoviesApp
//
//  Created by James Rochabrun on 7/6/20.
//

import UIKit


final class FilteredList<Element, FilterKey, RowContent>: UIView
    where RowContent: GenericCell<Element> {
    
    typealias RowContentProvider = (UITableView, Element, IndexPath) -> RowContent

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = nil
        tableView.backgroundView = nil
        tableView.register(RowContent.self)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        return tableView
    }()
    
    private var filterKey: KeyPath<Element, FilterKey>?
    var isIncluded: ((FilterKey) -> Bool)?
    private var rowContent: RowContentProvider?
    
    convenience init(
        _ items: [Element],
        filterBy key: KeyPath<Element, FilterKey>,
        rowContent: @escaping RowContentProvider
    ) {
        self.init(frame: .zero)
        self.filterKey = key
        self.rowContent = rowContent
        self.setupDataSource(items, rowContent: rowContent)
    }
    
    private var dataSource: GenericDataSource<RowContent, FilterKey, Element>?
    
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
                                 rowContent: @escaping RowContentProvider) {
        dataSource = GenericDataSource(models: items,
                                       filterBy: self.filterKey!,
                                       isIncluded: self.isIncluded!,
                                       configureCell: rowContent)
        tableView.dataSource = dataSource
        tableView.reloadData()        
    }
}

//
//  GenericDataSource.swift
//  UIKitMoviesApp
//
//  Created by James Rochabrun on 7/7/20.
//

import UIKit

final class GenericDataSource<RowContent, Element>: NSObject, UITableViewDataSource
        where Element: Searchable, RowContent: GenericCell<Element> {
    
    private var models: [Element]
    private let configureCell: CellConfiguration
   // typealias CellConfiguration = (UITableView, Element, IndexPath) -> RowContent
    typealias CellConfiguration = (RowContent, Element) -> RowContent

    
    private var searchResults: [Element] = []
    private var isSearchActive: Bool = false
    
    init(models: [Element], configureCell: @escaping CellConfiguration) {
        self.models = models
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchActive ? searchResults.count : models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: RowContent = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let model = getModelAt(indexPath)
        return configureCell(cell, model)
    }
    
    private func getModelAt(_ indexPath: IndexPath) -> Element {
        return isSearchActive ? searchResults[indexPath.item] :  models[indexPath.item]
    }
    
    /// external function for searching
    func search(query: String) {
        isSearchActive = !query.isEmpty
        searchResults = models.filter {
            let queryToFind = $0.query.range(of: query, options: NSString.CompareOptions.caseInsensitive)
            return (queryToFind != nil)
        }
    }
}

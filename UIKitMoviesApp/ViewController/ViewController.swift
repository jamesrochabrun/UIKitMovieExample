//
//  ViewController.swift
//  UIKitMoviesApp
//
//  Created by James Rochabrun on 7/6/20.
//

import UIKit
import Combine
import SwiftUI

class ViewController: UIViewController, UISearchBarDelegate, RemoveThis {
    
//    @ObservedObject private var client = MovieModel()
    
     private var client = MovieModel()

    lazy var filteredList: FilteredList<Movie, String, MovieCell>! = nil
    
    @State var searchPhrase = ""
    
    private let searchController = UISearchController(searchResultsController: nil)

    private func setUpSearchBar() {
          
          navigationItem.searchController = searchController
          navigationItem.hidesSearchBarWhenScrolling = false
         // searchController.dimsBackgroundDuringPresentation = false
          searchController.searchBar.delegate = self
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
        client.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func update(_ movies: [Movie]) {
        self.filteredList = FilteredList(movies,
                                         filterBy: \.title,
                                         rowContent: { tv, movie, indexPath in
                                            tv.register(MovieCell.self)
                                            let movieCell: MovieCell = tv.dequeueReusableCell(forIndexPath: indexPath)
                                            movieCell.item = movie
                                            return movieCell
                                         })
        arrangeFilteredList(filteredList)
    }
    
    func arrangeFilteredList(_ filteredList: FilteredList<Movie, String, MovieCell>) {
        view.addSubview(filteredList)
        filteredList.translatesAutoresizingMaskIntoConstraints = false
        
        filteredList.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        filteredList.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        filteredList.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        filteredList.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {


        
        
        
        
        let filteredList: FilteredList<Movie, String, MovieCell> = FilteredList(client.items,
                                        filterBy: \.title,
                                        rowContent: { tv, movie, indexPath in
                                            let movieCell: MovieCell = tv.dequeueReusableCell(forIndexPath: indexPath)
                                            movieCell.item = movie
                                            return movieCell
                                        })
        
        arrangeFilteredList(filteredList)
    }
}



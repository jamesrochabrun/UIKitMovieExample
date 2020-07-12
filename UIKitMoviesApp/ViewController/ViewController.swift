//
//  ViewController.swift
//  UIKitMoviesApp
//
//  Created by James Rochabrun on 7/6/20.
//

import UIKit
import Combine
import SwiftUI

class ViewController: UIViewController {
    
    @ObservedObject private var client = MovieModel()
    
    lazy var filteredList: FilteredList<Movie, String, MovieCell>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
//        client.getFeed(from: .nowPlaying) { result in
//            switch result {
//            case .success(let movieFeedResult):
//                guard let movieResults = movieFeedResult?.results else { return }
//
//                self.filteredList = FilteredList(movieResults,
//                                                 filterBy: \.title,
//                                                 isIncluded: { query in
//                                                    return true
//                                                 },
//                                                 rowContent: { movieCell, movie in
//                                                    movieCell.item = movie
//                                                    return movieCell
//                                                 })
//
//
//
//                self.view.addSubview(self.filteredList)
//                self.filteredList.translatesAutoresizingMaskIntoConstraints = false
//
//                self.filteredList.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
//                self.filteredList.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
//                self.filteredList.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
//                self.filteredList.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
//
//
//               // dump(movieResults)
//            case .failure(let error):
//                print("the error \(error)")
//            }
//        }

        
        // print("movies \($client.movies)")
        

        
        let filteredList = FilteredList(MovieCell.self,
                                        [Movie.emptyMovie],
                             filterBy: \.title,
                             isIncluded: { query in
                                return true
                             },
                             rowContent: { cell, movie in
//                                let movieCell: MovieCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                                cell.item = movie
                                return cell
                             })
    
        arrangeFilteredList(filteredList)
    }
    
    func arrangeFilteredList(_ filteredList: FilteredList<Movie, String, GenericCell<Movie>>) {
        view.addSubview(filteredList)
        filteredList.translatesAutoresizingMaskIntoConstraints = false
        
        filteredList.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        filteredList.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        filteredList.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        filteredList.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}



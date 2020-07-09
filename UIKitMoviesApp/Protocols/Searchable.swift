//
//  Searchable.swift
//  UIKitMoviesApp
//
//  Created by James Rochabrun on 7/7/20.
//

import UIKit

protocol Searchable: Identifiable {
    var query: String { get }
}

//
//  Game.swift
//  Jeopardy!
//
//  Created by Tyrone Trevorrow on 8/08/14.
//  Copyright (c) 2014 Sudeium. All rights reserved.
//

// An instance of a jeopardy game.

import UIKit

enum GameMode: String {
    case Jeopardy = "Jeopardy"
    case DoubleJeopardy = "Double Jeopardy"
    case FinalJeopardy = "Final Jeopardy"
}

class Game {
    let resourceBundle: NSBundle
    var categories: [Category]
    var mode: GameMode = .Jeopardy
    
    convenience init() {
        let bundle = NSBundle(URL: NSBundle.mainBundle().URLForResource("Game", withExtension: "bundle"))
        self.init(bundle: bundle)
    }
    
    init(bundle: NSBundle) {
        resourceBundle = bundle
        categories = []
        let boardURL = bundle.URLForResource("board", withExtension: "json")
        var error: NSError?
        let boardJSON = NSJSONSerialization.JSONObjectWithData(NSData(contentsOfURL: boardURL), options: nil, error: &error) as NSDictionary
        if let err = error {
            println(err.localizedDescription)
            return
        }
        let categoriesJSON = boardJSON["categories"] as [NSDictionary]
        for categoryJSON in categoriesJSON {
            categories.append(Category(fromJSON: categoryJSON, game: self))
        }
    }
}

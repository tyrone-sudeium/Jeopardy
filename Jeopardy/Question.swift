//
//  Question.swift
//  Jeopardy!
//
//  Created by Tyrone Trevorrow on 8/08/2014.
//  Copyright (c) 2014 Sudeium. All rights reserved.
//

import Foundation

class Question {
    let text: String = "Invalid question"
    let answer: String = "Invalid question"
    let value: Int = 0 // Currency in cents.
    var dailyDouble: Bool = false
    var imageURL: NSURL?
    var soundURL: NSURL?
    weak var category: Category?
    
    init() {
        
    }
    
    init(_ text: String, forAmount: Int, answer: String) {
        self.text = text
        value = forAmount
        self.answer = answer
        dailyDouble = false
    }
    
    init(_ text: String, forAmount: Int, answer: String, dailyDouble: Bool) {
        self.text = text
        value = forAmount
        self.answer = answer
        self.dailyDouble = dailyDouble
    }
    
    init(fromJSON json: NSDictionary, bundle: NSBundle?) {
        let str: String? = json["text"] as? String
        let valNum: Int? = json["value"] as? Int
        let answer: String? = json["answer"] as? String
        let dailyDouble: Bool? = json["daily_double"] as? Bool
        if str != nil {
            self.text = str!
        }
        if valNum != nil {
            self.value = valNum!
        }
        if answer != nil {
            self.answer = answer!
        }
        if dailyDouble != nil {
            self.dailyDouble = dailyDouble!
        }
        parseURLFromJSON(json, bundle: bundle, jsonKey: "image") { url in
            self.imageURL = url
        }
        parseURLFromJSON(json, bundle: bundle, jsonKey: "sound") { url in
            self.soundURL = url
        }
    }
    
    convenience init(fromJSON json: NSDictionary, category: Category) {
        self.init(fromJSON: json, bundle: category.game?.resourceBundle)
        self.category = category
    }
    
    func parseURLFromJSON(json: NSDictionary, bundle: NSBundle?, jsonKey: String, whenDone: NSURL -> Void) {
        if let img = json[jsonKey] as? String {
            if let url = bundle?.URLForResource(img.stringByDeletingPathExtension, withExtension: img.pathExtension) {
                whenDone(url)
            }
        }
    }
}

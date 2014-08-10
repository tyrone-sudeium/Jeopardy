//
//  Question.swift
//  Jeopardy!
//
//  Created by Tyrone Trevorrow on 8/08/2014.
//  Copyright (c) 2014 Sudeium. All rights reserved.
//

import Foundation

class Question {
    let text: String
    let answer: String
    let value: Int32 // Currency in cents.
    var dailyDouble: Bool
    var imageURL: NSURL?
    var soundURL: NSURL?
    weak var category: Category?
    
    init(_ text: String, forAmount: Int32, answer: String) {
        self.text = text
        self.value = forAmount
        self.answer = answer
        self.dailyDouble = false
    }
    
    init(_ text: String, forAmount: Int32, answer: String, dailyDouble: Bool) {
        self.text = text
        self.value = forAmount
        self.answer = answer
        self.dailyDouble = dailyDouble
    }
    
    convenience init(fromJSON json: NSDictionary, bundle: NSBundle?) {
        var str: String? = json["text"] as? String
        var valNum: NSNumber? = json["value"] as? NSNumber
        var val: Int32
        if str == .None {
            str = "Invalid question"
        }
        if valNum == .None {
            val = 0
        } else {
            val = Int32(valNum!.integerValue)
        }
        var answer: String? = json["answer"] as? String
        if answer == .None {
            answer = "Invalid question"
        }
        var dailyDouble: Bool? = json["daily_double"] as? Bool
        if dailyDouble == .None {
            dailyDouble = false
        }
        self.init(str!, forAmount: val, answer: answer!, dailyDouble: dailyDouble!)
        self.parseURLFromJSON(json, bundle: bundle, jsonKey: "image") { url in
            self.imageURL = url
        }
        self.parseURLFromJSON(json, bundle: bundle, jsonKey: "sound") { url in
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

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
    let value: Int32 // Currency in cents.
    var imageURL: NSURL?
    weak var category: Category?
    
    init(_ text: String, forAmount: Int32) {
        self.text = text
        self.value = forAmount
    }
    
    convenience init(fromJSON json: NSDictionary) {
        let str = json["text"] as String
        let val = Int32((json["value"] as NSNumber).integerValue)
        self.init(str, forAmount: val)
    }
    
    convenience init(fromJSON json: NSDictionary, category: Category) {
        self.init(fromJSON: json)
        self.category = category
    }
}

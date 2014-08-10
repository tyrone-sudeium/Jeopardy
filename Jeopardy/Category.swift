//
//  Category.swift
//  Jeopardy!
//
//  Created by Tyrone Trevorrow on 8/08/2014.
//  Copyright (c) 2014 Sudeium. All rights reserved.
//

import Foundation

class Category {
    let questions: [Question]
    let title: String
    weak var game: Game?
    
    init(_ title: String, questions: [Question]) {
        self.title = title
        self.questions = questions
    }
    
    convenience init(fromJSON json: NSDictionary, game: Game?) {
        let questionsJSON = json["questions"] as [NSDictionary]
        let title = json["title"] as String
        var qs: [Question] = []
        
        for json in questionsJSON {
            let q = Question(fromJSON: json, bundle: game?.resourceBundle)
            qs.append(q)
        }
        self.init(title, questions: qs)
        
        for question in self.questions {
            question.category = self
        }
    }
}

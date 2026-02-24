//
//  Question.swift
//  HPTrivia
//
//  Created by ceboi on 21/02/26.
//

struct Question: Decodable {
    let id: Int
    let question: String
    let answer: String
    let wrong: [String]
    let book: Int
    let hint: String
}

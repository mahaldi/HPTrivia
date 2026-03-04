//
//  Book.swift
//  HPTrivia
//
//  Created by ceboi on 26/02/26.
//

struct Book: Identifiable {
    let id: Int
    let image: String
    let questions: [Question]
    
    var status: BookStatus
    
}

enum BookStatus {
    case active, inactive, locked
}

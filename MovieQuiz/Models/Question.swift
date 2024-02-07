//
//  Question.swift
//  MovieQuiz
//
//  Created by Apple on 07.02.2024.
//

import Foundation

struct Question {
    let image: String
    let rating: Double
    let question: String
    let answer: Bool
}

struct MokQuestionManager {
    let questions: [Question] = [
        Question(image: "The Godfather", rating: 9.2, question: "Рейтинг этого фильма\n больше чем 6?", answer: true),
        Question(image: "The Dark Knight", rating: 9, question: "Рейтинг этого фильма\n больше чем 6?", answer: true),
        Question(image: "Kill Bill", rating: 8.1, question: "Рейтинг этого фильма\n больше чем 6?", answer: true),
        Question(image: "The Avengers", rating: 8, question: "Рейтинг этого фильма\n больше чем 6?", answer: true),
        Question(image: "Deadpool", rating: 8, question: "Рейтинг этого фильма\n больше чем 6?", answer: true),
        Question(image: "The Green Knight", rating: 6.6, question: "Рейтинг этого фильма\n больше чем 6?", answer: true),
        Question(image: "Old", rating: 5.8, question: "Рейтинг этого фильма\n больше чем 6?", answer: false),
        Question(image: "The Ice Age Adventures of Buck Wild", rating: 4.3, question: "Рейтинг этого фильма\n больше чем 6?", answer: false),
        Question(image: "Tesla", rating: 5.1, question: "Рейтинг этого фильма\n больше чем 6?", answer: false),
        Question(image: "Vivarium", rating: 5.8, question: "Рейтинг этого фильма\n больше чем 6?", answer: false)
    ]
}

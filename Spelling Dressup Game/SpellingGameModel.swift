//
//  SpellingGameModel.swift
//  Spelling Dressup Game
//

import Foundation
import Observation

@MainActor
@Observable
final class SpellingGameModel {
    // MARK: - Stored properties

    let animals: [Animal] = [
        Animal(id: "cat", name: "cat", emoji: "🐱"),
        Animal(id: "dog", name: "dog", emoji: "🐶"),
        Animal(id: "elephant", name: "elephant", emoji: "🐘"),
        Animal(id: "giraffe", name: "giraffe", emoji: "🦒"),
        Animal(id: "lion", name: "lion", emoji: "🦁"),
        Animal(id: "monkey", name: "monkey", emoji: "🐒"),
        Animal(id: "penguin", name: "penguin", emoji: "🐧"),
        Animal(id: "rabbit", name: "rabbit", emoji: "🐰"),
        Animal(id: "turtle", name: "turtle", emoji: "🐢"),
        Animal(id: "zebra", name: "zebra", emoji: "🦓"),
        Animal(id: "butterfly", name: "butterfly", emoji: "🦋"),
        Animal(id: "dolphin", name: "dolphin", emoji: "🐬"),
        Animal(id: "fox", name: "fox", emoji: "🦊"),
        Animal(id: "owl", name: "owl", emoji: "🦉"),
        Animal(id: "panda", name: "panda", emoji: "🐼")
    ]

    var currentIndex = 0
    var answer = ""
    var feedback: AnswerFeedback = .waiting

    // MARK: - Computed properties

    var currentAnimal: Animal {
        animals[currentIndex]
    }

    var isLastQuestion: Bool {
        currentIndex == animals.count - 1
    }

    // MARK: - Functions

    func checkAnswer() {
        let trimmedAnswer = answer.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedAnswer.isEmpty else {
            feedback = .waiting
            return
        }

        if trimmedAnswer.localizedCaseInsensitiveCompare(currentAnimal.name) == .orderedSame {
            feedback = .correct
        } else {
            feedback = .incorrect(correctAnswer: currentAnimal.name)
        }
    }

    func moveToNextAnimal() {
        guard !isLastQuestion else {
            restart()
            return
        }

        currentIndex += 1
        answer = ""
        feedback = .waiting
    }

    func restart() {
        currentIndex = 0
        answer = ""
        feedback = .waiting
    }
}

enum AnswerFeedback: Equatable {
    case waiting
    case correct
    case incorrect(correctAnswer: String)
}

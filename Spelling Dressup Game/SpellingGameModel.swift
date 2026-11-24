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

    let difficulty: SpellingDifficulty
    var animals: [Animal]
    var currentIndex = 0
    var answer = ""
    var feedback: AnswerFeedback = .waiting
    var isCompleted = false

    // MARK: - Initializer

    init(difficulty: SpellingDifficulty) {
        self.difficulty = difficulty
        self.animals = difficulty.animals
        self.animals.shuffle()
    }

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
            isCompleted = true
            return
        }

        currentIndex += 1
        answer = ""
        feedback = .waiting
    }

    func restart() {
        animals = difficulty.animals
        animals.shuffle()
        currentIndex = 0
        answer = ""
        feedback = .waiting
        isCompleted = false
    }
}

enum AnswerFeedback: Equatable {
    case waiting
    case correct
    case incorrect(correctAnswer: String)
}

enum SpellingDifficulty: String, CaseIterable, Identifiable {
    case easy = "Easy"
    case hard = "Hard"
    case insane = "Insane"

    var id: String {
        rawValue
    }

    var animals: [Animal] {
        switch self {
        case .easy:
            return [
                Animal(id: "cat", name: "cat", imageName: "animal-cat"),
                Animal(id: "dog", name: "dog", imageName: "animal-dog"),
                Animal(id: "elephant", name: "elephant", imageName: "animal-elephant"),
                Animal(id: "giraffe", name: "giraffe", imageName: "animal-giraffe"),
                Animal(id: "lion", name: "lion", imageName: "animal-lion"),
                Animal(id: "monkey", name: "monkey", imageName: "animal-monkey"),
                Animal(id: "penguin", name: "penguin", imageName: "animal-penguin"),
                Animal(id: "rabbit", name: "rabbit", imageName: "animal-rabbit"),
                Animal(id: "turtle", name: "turtle", imageName: "animal-turtle"),
                Animal(id: "zebra", name: "zebra", imageName: "animal-zebra"),
                Animal(id: "butterfly", name: "butterfly", imageName: "animal-butterfly"),
                Animal(id: "dolphin", name: "dolphin", imageName: "animal-dolphin"),
                Animal(id: "fox", name: "fox", imageName: "animal-fox"),
                Animal(id: "owl", name: "owl", imageName: "animal-owl"),
                Animal(id: "panda", name: "panda", imageName: "animal-panda")
            ]
        case .hard:
            return [
                Animal(id: "kangaroo", name: "kangaroo", imageName: "animal-kangaroo"),
                Animal(id: "cheetah", name: "cheetah", imageName: "animal-cheetah"),
                Animal(id: "flamingo", name: "flamingo", imageName: "animal-flamingo"),
                Animal(id: "octopus", name: "octopus", imageName: "animal-octopus"),
                Animal(id: "peacock", name: "peacock", imageName: "animal-peacock"),
                Animal(id: "rhinoceros", name: "rhinoceros", imageName: "animal-rhinoceros"),
                Animal(id: "squirrel", name: "squirrel", imageName: "animal-squirrel"),
                Animal(id: "seal", name: "seal", imageName: "animal-seal"),
                Animal(id: "porcupine", name: "porcupine", imageName: "animal-porcupine"),
                Animal(id: "crocodile", name: "crocodile", imageName: "animal-crocodile"),
                Animal(id: "hippopotamus", name: "hippopotamus", imageName: "animal-hippopotamus"),
                Animal(id: "lobster", name: "lobster", imageName: "animal-lobster"),
                Animal(id: "reindeer", name: "reindeer", imageName: "animal-reindeer"),
                Animal(id: "alligator", name: "alligator", imageName: "animal-alligator"),
                Animal(id: "armadillo", name: "armadillo", imageName: "animal-armadillo")
            ]
        case .insane:
            return [
                Animal(id: "chimpanzee", name: "chimpanzee", imageName: "animal-chimpanzee"),
                Animal(id: "orangutan", name: "orangutan", imageName: "animal-orangutan"),
                Animal(id: "platypus", name: "platypus", imageName: "animal-platypus"),
                Animal(id: "axolotl", name: "axolotl", imageName: "animal-axolotl"),
                Animal(id: "echidna", name: "echidna", imageName: "animal-echidna"),
                Animal(id: "narwhal", name: "narwhal", imageName: "animal-narwhal"),
                Animal(id: "ostrich", name: "ostrich", imageName: "animal-ostrich"),
                Animal(id: "wildebeest", name: "wildebeest", imageName: "animal-wildebeest"),
                Animal(id: "cockatoo", name: "cockatoo", imageName: "animal-cockatoo"),
                Animal(id: "swordfish", name: "swordfish", imageName: "animal-swordfish"),
                Animal(id: "seahorse", name: "seahorse", imageName: "animal-seahorse"),
                Animal(id: "salamander", name: "salamander", imageName: "animal-salamander"),
                Animal(id: "chameleon", name: "chameleon", imageName: "animal-chameleon"),
                Animal(id: "meerkat", name: "meerkat", imageName: "animal-meerkat"),
                Animal(id: "coelacanth", name: "coelacanth", imageName: "animal-coelacanth")
            ]
        }
    }
}

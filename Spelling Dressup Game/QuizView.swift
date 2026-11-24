//
//  QuizView.swift
//  Spelling Dressup Game
//

import SwiftUI

struct QuizView: View {
    let difficulty: SpellingDifficulty
    @State private var game: SpellingGameModel
    @FocusState private var isAnswerFieldFocused: Bool

    init(difficulty: SpellingDifficulty) {
        self.difficulty = difficulty
        self._game = State(initialValue: SpellingGameModel(difficulty: difficulty))
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                AnimalPictureView(
                    animal: game.currentAnimal,
                    questionNumber: game.currentIndex + 1,
                    totalQuestions: game.animals.count
                )
                .frame(height: geometry.size.height * 0.52)

                AnswerEntryView(
                    answer: $game.answer,
                    feedback: game.feedback,
                    isAnswerFieldFocused: $isAnswerFieldFocused,
                    isLastQuestion: game.isLastQuestion,
                    submitAction: submitAnswer,
                    nextAction: showNextAnimal,
                    restartAction: restartGame
                )
                .frame(height: geometry.size.height * 0.48)
            }
        }
        .frame(minWidth: 620, minHeight: 700)
        .background(Color(nsColor: .windowBackgroundColor))
        .navigationTitle("\(difficulty.rawValue) Animal Spelling")
        .task {
            isAnswerFieldFocused = true
        }
    }

    private func submitAnswer() {
        game.checkAnswer()
    }

    private func showNextAnimal() {
        game.moveToNextAnimal()
        isAnswerFieldFocused = true
    }

    private func restartGame() {
        game.restart()
        isAnswerFieldFocused = true
    }
}

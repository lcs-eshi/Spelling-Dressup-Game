//
//  QuizView.swift
//  Spelling Dressup Game
//

import SwiftUI

struct QuizView: View {
    // MARK: - Stored properties

    let difficulty: SpellingDifficulty
    @State private var game: SpellingGameModel
    @FocusState private var isAnswerFieldFocused: Bool
    @Environment(\.dismiss) private var dismiss

    init(difficulty: SpellingDifficulty) {
        self.difficulty = difficulty
        self._game = State(initialValue: SpellingGameModel(difficulty: difficulty))
    }

    var body: some View {
        if game.isCompleted {
            completionView
        } else {
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
                        nextAction: showNextAnimal
                    )
                    .frame(height: geometry.size.height * 0.48)
                }
            }
            .frame(minWidth: 620, minHeight: 700)
            .background(Color(nsColor: .windowBackgroundColor))
            .navigationTitle("\(difficulty.rawValue) Animal Spelling")
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button("Exit to Home", systemImage: "house", action: dismiss)
                }
            }
            .task {
                isAnswerFieldFocused = true
            }
        }
    }

    // MARK: - Functions

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

    private var completionView: some View {
        VStack(spacing: 24) {
            Spacer()

            Image(systemName: "trophy.fill")
                .font(.system(size: 96))
                .foregroundStyle(.yellow)

            Text("Congratulations!")
                .font(.largeTitle)
                .bold()

            Text("You finished all 15 \(difficulty.rawValue.lowercased()) animals!")
                .font(.title2)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)

            HStack(spacing: 16) {
                Button("Play Again", systemImage: "arrow.clockwise", action: restartGame)
                    .buttonStyle(.borderedProminent)

                Button("Exit to Home", systemImage: "house", action: dismiss)
                    .buttonStyle(.bordered)
            }
            .controlSize(.large)

            Spacer()
        }
        .frame(minWidth: 620, minHeight: 700)
        .background(
            LinearGradient(
                colors: [Color.yellow.opacity(0.22), Color.orange.opacity(0.08)],
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .navigationTitle("Quiz Complete")
    }
}

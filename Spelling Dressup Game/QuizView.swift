//
//  QuizView.swift
//  Spelling Dressup Game
//  Developed with GitHub Copilot assistance.
//

import SwiftUI

struct QuizView: View {
    // MARK: - Stored properties

    @State private var difficulty: SpellingDifficulty
    let mode: SpellingMode
    @State private var game: SpellingGameModel
    @FocusState private var isAnswerFieldFocused: Bool
    @Environment(\.dismiss) private var dismiss

    init(difficulty: SpellingDifficulty, mode: SpellingMode = .practice) {
        self._difficulty = State(initialValue: difficulty)
        self.mode = mode
        self._game = State(initialValue: SpellingGameModel(difficulty: difficulty, mode: mode))
    }

    var body: some View {
        if game.isCompleted {
            completionView
        } else {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    if mode == .challenge {
                        VStack(spacing: 8) {
                            HStack {
                                Label("Time remaining", systemImage: "timer")
                                    .font(.headline)

                                Spacer()

                                Text(game.remainingTimeText)
                                    .font(.title2)
                                    .bold()
                                    .monospacedDigit()
                                    .foregroundStyle(game.remainingSeconds <= 10 ? .red : .primary)
                            }

                            ProgressView(
                                value: Double(game.remainingSeconds),
                                total: Double(difficulty.timeLimitSeconds)
                            )
                            .tint(game.remainingSeconds <= 10 ? .red : .accentColor)
                        }
                        .padding(.horizontal, 34)
                        .padding(.vertical, 10)
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel("Time remaining")
                        .accessibilityValue(game.remainingTimeText)
                    }

                    AnimalPictureView(
                        animal: game.currentAnimal,
                        questionNumber: game.questionNumber,
                        totalQuestions: game.totalQuestions
                    )
                    .frame(height: geometry.size.height * (mode == .challenge ? 0.47 : 0.52))

                    AnswerEntryView(
                        answer: $game.answer,
                        feedback: game.feedback,
                        isAnswerFieldFocused: $isAnswerFieldFocused,
                        isLastQuestion: game.isLastQuestion,
                        mode: mode,
                        submitAction: submitAnswer,
                        nextAction: showNextAnimal
                    )
                    .frame(height: geometry.size.height * (mode == .challenge ? 0.43 : 0.48))
                }
            }
            .frame(minWidth: 620, minHeight: 700)
            .background(Color(nsColor: .windowBackgroundColor))
            .navigationTitle("\(difficulty.rawValue) Animal Spelling")
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button("Exit to Home", systemImage: "house") {
                        exitToHome()
                    }
                }
            }
            .task {
                isAnswerFieldFocused = true
            }
            .task(id: game.feedback) {
                guard mode != .practice, case .incorrect = game.feedback else {
                    return
                }

                try? await Task.sleep(for: .seconds(1.5))
                guard !Task.isCancelled else {
                    return
                }
                showNextAnimal()
            }
            .task(id: difficulty) {
                guard mode == .challenge else {
                    return
                }

                while !game.isCompleted {
                    try? await Task.sleep(for: .seconds(1))
                    guard !Task.isCancelled else {
                        return
                    }
                    game.countDownChallengeSecond()
                }
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

    private func exitToHome() {
        game.restart()
        dismiss()
    }

    private func startNextLevel(_ nextDifficulty: SpellingDifficulty) {
        difficulty = nextDifficulty
        game = SpellingGameModel(difficulty: nextDifficulty, mode: mode)
        isAnswerFieldFocused = true
    }

    private var completionView: some View {
        VStack(spacing: 24) {
            Spacer()

            Image(systemName: "trophy.fill")
                .font(.system(size: 96))
                .foregroundStyle(.yellow)

            Text(game.didFailChallenge ? "Time's Up!" : "Congratulations!")
                .font(.largeTitle)
                .bold()

            if game.didFailChallenge {
                Text("You ran out of time before completing the challenge.")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
            } else {
                Text("You finished all \(game.totalQuestions) \(difficulty.rawValue.lowercased()) animals!")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
            }

            if !game.didFailChallenge, mode == .challenge {
                Text("Completion time: \(game.elapsedTimeText)")
                    .font(.title3)
                    .monospacedDigit()
            }

            if mode == .quiz {
                Text("Score: \(game.score) out of \(game.totalQuestions)")
                    .font(.title3)
                    .bold()
            }

            if game.didFailChallenge {
                Text("Choose Play Again to try the challenge again.")
                    .font(.headline)
                    .foregroundStyle(.secondary)
            } else if let nextDifficulty = difficulty.nextLevel {
                Button("Next Level: \(nextDifficulty.rawValue)", systemImage: "arrow.right") {
                    startNextLevel(nextDifficulty)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            } else {
                Text("You completed every level!")
                    .font(.headline)
                    .foregroundStyle(.secondary)
            }

            HStack(spacing: 16) {
                Button("Play Again", systemImage: "arrow.clockwise", action: restartGame)
                    .buttonStyle(.bordered)
                Button("Exit to Home", systemImage: "house") {
                    exitToHome()
                }
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

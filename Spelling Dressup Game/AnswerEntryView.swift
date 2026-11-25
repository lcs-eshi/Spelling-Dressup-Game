//
//  AnswerEntryView.swift
//  Spelling Dressup Game
//  Developed with GitHub Copilot assistance.
//

import SwiftUI

struct AnswerEntryView: View {
    @Binding var answer: String
    let feedback: AnswerFeedback
    @FocusState.Binding var isAnswerFieldFocused: Bool
    let isLastQuestion: Bool
    let mode: SpellingMode
    let submitAction: () -> Void
    let nextAction: () -> Void

    var body: some View {
        VStack(spacing: 18) {
            Spacer()

            Text("Type the animal's name")
                .font(.title2)
                .bold()

            TextField("Type your answer", text: $answer)
                .textFieldStyle(.roundedBorder)
                .font(.title3)
                .focused($isAnswerFieldFocused)
                .onSubmit(submitAction)
                .accessibilityLabel("Animal name answer")
                .frame(maxWidth: 460)
                .disabled(isAdvancingAfterIncorrectAnswer)

            feedbackView

            actionButtons

            Spacer()
        }
        .padding(.horizontal, 34)
        .padding(.vertical, 24)
        .background(Color(nsColor: .controlBackgroundColor))
    }

    @ViewBuilder
    private var feedbackView: some View {
        switch feedback {
        case .waiting:
            Text("You can do it!")
                .foregroundStyle(.secondary)
        case .correct:
            Label("Great job!", systemImage: "checkmark.circle.fill")
                .foregroundStyle(.green)
                .bold()
        case .incorrect(let correctAnswer):
            Text(incorrectAnswerMessage(correctAnswer))
                .foregroundStyle(.orange)
                .bold()
        }
    }

    private var isAdvancingAfterIncorrectAnswer: Bool {
        guard mode != .practice else {
            return false
        }

        if case .incorrect = feedback {
            return true
        }

        return false
    }

    private func incorrectAnswerMessage(_ correctAnswer: String) -> String {
        switch mode {
        case .practice:
            return "Try again. The answer is \(correctAnswer)."
        case .challenge:
            return "The answer is \(correctAnswer). It will return later."
        case .quiz:
            return "The answer is \(correctAnswer). Moving to the next question."
        }
    }

    private var actionButtons: some View {
        HStack(spacing: 12) {
            Button("Check Answer", systemImage: "checkmark") {
                submitAction()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .font(.headline)
            .frame(minWidth: 180, minHeight: 52)
            .keyboardShortcut(.return, modifiers: [])
            .disabled(isAdvancingAfterIncorrectAnswer)

            if feedback == .correct {
                Button(isLastQuestion ? "Finish Quiz" : "Next Animal", systemImage: "arrow.right", action: nextAction)
                .buttonStyle(.bordered)
                .controlSize(.large)
                .font(.headline)
                .frame(minWidth: 180, minHeight: 52)
            }
        }
    }
}

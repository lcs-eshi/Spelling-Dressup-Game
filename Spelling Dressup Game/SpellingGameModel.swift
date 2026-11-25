//
//  SpellingGameModel.swift
//  Spelling Dressup Game
//  Developed with GitHub Copilot assistance.
//

import Foundation
import Observation

@MainActor
@Observable
final class SpellingGameModel {
    // MARK: - Stored properties

    let difficulty: SpellingDifficulty
    let mode: SpellingMode
    var animals: [Animal]
    var currentIndex = 0
    var answer = ""
    var feedback: AnswerFeedback = .waiting
    var isCompleted = false
    var didFailChallenge = false
    private(set) var score = 0
    private(set) var remainingSeconds: Int
    private(set) var elapsedSeconds = 0
    private var retryQueue: [Animal] = []
    private var correctlyAnsweredIDs: Set<String> = []

    // MARK: - Initializer

    init(difficulty: SpellingDifficulty, mode: SpellingMode = .practice) {
        self.difficulty = difficulty
        self.mode = mode
        self.animals = difficulty.animals
        self.remainingSeconds = mode == .challenge ? difficulty.timeLimitSeconds : 0
        self.animals.shuffle()
    }

    // MARK: - Computed properties

    var currentAnimal: Animal {
        animals[currentIndex]
    }

    var isLastQuestion: Bool {
        guard currentIndex == animals.count - 1 else {
            return false
        }

        return mode != .challenge || retryQueue.isEmpty
    }

    var totalQuestions: Int {
        difficulty.animals.count
    }

    var questionNumber: Int {
        if mode == .challenge {
            return min(score + 1, totalQuestions)
        }

        return min(currentIndex + 1, totalQuestions)
    }

    var remainingTimeText: String {
        Self.timeText(for: remainingSeconds)
    }

    var elapsedTimeText: String {
        Self.timeText(for: elapsedSeconds)
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
            let insertedAnswer = correctlyAnsweredIDs.insert(currentAnimal.id).inserted
            if insertedAnswer {
                score += 1
            }
        } else {
            feedback = .incorrect(correctAnswer: currentAnimal.name)
            if mode == .challenge {
                retryQueue.append(currentAnimal)
            }
        }
    }

    func moveToNextAnimal() {
        guard !isCompleted else {
            return
        }

        if currentIndex < animals.count - 1 {
            currentIndex += 1
        } else if mode == .challenge, !retryQueue.isEmpty {
            animals = retryQueue
            retryQueue = []
            currentIndex = 0
        } else {
            isCompleted = true
            return
        }

        answer = ""
        feedback = .waiting
    }

    func countDownChallengeSecond() {
        guard mode == .challenge, !isCompleted else {
            return
        }

        remainingSeconds = max(0, remainingSeconds - 1)
        elapsedSeconds += 1

        if remainingSeconds == 0 {
            didFailChallenge = true
            isCompleted = true
        }
    }

    func restart() {
        animals = difficulty.animals
        animals.shuffle()
        retryQueue = []
        correctlyAnsweredIDs = []
        currentIndex = 0
        answer = ""
        feedback = .waiting
        isCompleted = false
        didFailChallenge = false
        score = 0
        remainingSeconds = mode == .challenge ? difficulty.timeLimitSeconds : 0
        elapsedSeconds = 0
    }

    private static func timeText(for seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%d:%02d", minutes, remainingSeconds)
    }
}

enum AnswerFeedback: Equatable {
    case waiting
    case correct
    case incorrect(correctAnswer: String)
}

enum SpellingMode: String, CaseIterable, Identifiable {
    case challenge = "Challenge"
    case practice = "Practice"
    case quiz = "Quiz"

    var id: String {
        rawValue
    }

    var description: String {
        switch self {
        case .challenge:
            return "Race the timer: 1 minute for Easy, 2 for Hard, and 3 for Insane. Missed animals return until correct."
        case .practice:
            return "Practice at your own pace. Keep trying until each answer is correct."
        case .quiz:
            return "Answer each animal once and see your score out of 15."
        }
    }
}

enum SpellingDifficulty: String, CaseIterable, Identifiable {
    case easy = "Easy"
    case hard = "Hard"
    case insane = "Insane"

    var id: String {
        rawValue
    }

    var nextLevel: SpellingDifficulty? {
        switch self {
        case .easy:
            return .hard
        case .hard:
            return .insane
        case .insane:
            return nil
        }
    }

    var timeLimitSeconds: Int {
        switch self {
        case .easy:
            return 60
        case .hard:
            return 120
        case .insane:
            return 180
        }
    }

    var animals: [Animal] {
        switch self {
        case .easy:
            return [
                Animal(id: "cat", name: "cat", imageName: "animal-cat", funFact: "A cat's whiskers are sensitive touch hairs that help it sense nearby objects and spaces.", factSourceURL: "https://www.britannica.com/animal/cat"),
                Animal(id: "dog", name: "dog", imageName: "animal-dog", funFact: "A dog's sense of smell is far more sensitive than a human's.", factSourceURL: "https://www.britannica.com/animal/dog"),
                Animal(id: "elephant", name: "elephant", imageName: "animal-elephant", funFact: "Elephants are the largest living land animals.", factSourceURL: "https://www.britannica.com/animal/elephant", imageCredit: "Outforia", imageSourceURL: "https://outforia.com/types-of-elephants/"),
                Animal(id: "giraffe", name: "giraffe", imageName: "animal-giraffe", funFact: "Giraffes are the tallest living land animals.", factSourceURL: "https://www.britannica.com/animal/giraffe"),
                Animal(id: "lion", name: "lion", imageName: "animal-lion", funFact: "A group of lions is called a pride.", factSourceURL: "https://www.britannica.com/animal/lion", imageCredit: "In Our Nature Magazine", imageSourceURL: "https://www.inournaturemag.com/all/african-lion-the-next-endangered-animal"),
                Animal(id: "monkey", name: "monkey", imageName: "animal-monkey", funFact: "Some monkeys have prehensile tails that can grasp branches.", factSourceURL: "https://www.britannica.com/animal/monkey"),
                Animal(id: "penguin", name: "penguin", imageName: "animal-penguin", funFact: "Penguins use their wings like flippers to swim underwater.", factSourceURL: "https://www.britannica.com/animal/penguin"),
                Animal(id: "rabbit", name: "rabbit", imageName: "animal-rabbit", funFact: "A rabbit's front teeth keep growing throughout its life.", factSourceURL: "https://www.britannica.com/animal/rabbit"),
                Animal(id: "turtle", name: "turtle", imageName: "animal-turtle", funFact: "A turtle's shell is part of its skeleton and includes bones from its ribs and spine.", factSourceURL: "https://www.britannica.com/animal/turtle-reptile"),
                Animal(id: "zebra", name: "zebra", imageName: "animal-zebra", funFact: "Zebra foals are born with brown stripes that darken as they grow.", factSourceURL: "https://www.britannica.com/animal/zebra-mammal"),
                Animal(id: "butterfly", name: "butterfly", imageName: "animal-butterfly", funFact: "Butterflies taste using sensors on their feet.", factSourceURL: "https://www.britannica.com/animal/butterfly-insect"),
                Animal(id: "dolphin", name: "dolphin", imageName: "animal-dolphin", funFact: "Many dolphins use echolocation clicks and returning echoes to locate objects.", factSourceURL: "https://www.britannica.com/animal/dolphin-mammal"),
                Animal(id: "fox", name: "fox", imageName: "animal-fox", funFact: "A red fox can use its bushy tail for balance and wrap it around itself for warmth.", factSourceURL: "https://www.britannica.com/animal/fox-mammal"),
                Animal(id: "owl", name: "owl", imageName: "animal-owl", funFact: "An owl's eyes cannot turn in their sockets, so it turns its head to look around.", factSourceURL: "https://www.britannica.com/animal/owl", imageCredit: "Greg Hume / Wikimedia Commons", imageSourceURL: "https://commons.wikimedia.org/wiki/File:Bubo_virginianus_06.jpg", imageLicense: "CC BY-SA 3.0", imageLicenseURL: "https://creativecommons.org/licenses/by-sa/3.0/"),
                Animal(id: "panda", name: "panda", imageName: "animal-panda", funFact: "A giant panda has an enlarged wrist bone that works like a thumb to help grip bamboo.", factSourceURL: "https://www.britannica.com/animal/giant-panda")
            ]
        case .hard:
            return [
                Animal(id: "kangaroo", name: "kangaroo", imageName: "animal-kangaroo", funFact: "A newborn kangaroo is tiny and crawls into its mother's pouch, where it continues developing.", factSourceURL: "https://www.britannica.com/animal/kangaroo"),
                Animal(id: "cheetah", name: "cheetah", imageName: "animal-cheetah", funFact: "The cheetah is the fastest land animal.", factSourceURL: "https://www.britannica.com/animal/cheetah-mammal", imageCredit: "Derek Keats / Wikimedia Commons", imageSourceURL: "https://commons.wikimedia.org/wiki/File:Cheetah,_Acinonyx_jubatus,_at_Pilanesberg_National_Park,_Northwest_Province,_South_Africa._(27551650726).jpg", imageLicense: "CC BY 2.0", imageLicenseURL: "https://creativecommons.org/licenses/by/2.0/"),
                Animal(id: "flamingo", name: "flamingo", imageName: "animal-flamingo", funFact: "A flamingo's pink color comes from pigments in the food it eats.", factSourceURL: "https://www.britannica.com/animal/flamingo", imageCredit: "Manuelito2021consupadre / Wikimedia Commons", imageSourceURL: "https://commons.wikimedia.org/wiki/File:Chilensis_P_L.jpg", imageLicense: "CC BY-SA 4.0", imageLicenseURL: "https://creativecommons.org/licenses/by-sa/4.0/"),
                Animal(id: "octopus", name: "octopus", imageName: "animal-octopus", funFact: "An octopus has three hearts.", factSourceURL: "https://www.britannica.com/animal/octopus-mollusk"),
                Animal(id: "peacock", name: "peacock", imageName: "animal-peacock", funFact: "The male peafowl's long display feathers are tail-coverts, not its short true tail feathers.", factSourceURL: "https://www.britannica.com/animal/peafowl"),
                Animal(id: "rhinoceros", name: "rhinoceros", imageName: "animal-rhinoceros", funFact: "A rhino's horn is made of keratin, the same protein found in human hair and nails.", factSourceURL: "https://www.britannica.com/animal/rhinoceros-mammal", imageCredit: "Giles Laurent / Wikimedia Commons", imageSourceURL: "https://commons.wikimedia.org/wiki/File:081_White_rhinoceros_(male)_in_the_Kalahari_Desert_of_Namibia_Photo_by_Giles_Laurent.jpg", imageLicense: "CC BY-SA 4.0", imageLicenseURL: "https://creativecommons.org/licenses/by-sa/4.0/"),
                Animal(id: "squirrel", name: "squirrel", imageName: "animal-squirrel", funFact: "A squirrel's front teeth keep growing, so gnawing helps wear them down.", factSourceURL: "https://www.britannica.com/animal/squirrel"),
                Animal(id: "seal", name: "seal", imageName: "animal-seal", funFact: "A seal's layer of blubber helps insulate it from cold water.", factSourceURL: "https://www.britannica.com/animal/seal-mammal", imageCredit: "iStock", imageSourceURL: "https://www.istockphoto.com/photos/seal-snow"),
                Animal(id: "porcupine", name: "porcupine", imageName: "animal-porcupine", funFact: "Porcupines cannot shoot their quills; the quills detach when touched.", factSourceURL: "https://www.britannica.com/animal/porcupine"),
                Animal(id: "crocodile", name: "crocodile", imageName: "animal-crocodile", funFact: "Crocodiles can replace their teeth throughout their lives.", factSourceURL: "https://www.britannica.com/animal/crocodile"),
                Animal(id: "hippopotamus", name: "hippopotamus", imageName: "animal-hippopotamus", funFact: "Hippos spend much of the day in water and usually come ashore at night to graze.", factSourceURL: "https://www.britannica.com/animal/hippopotamus"),
                Animal(id: "lobster", name: "lobster", imageName: "animal-lobster", funFact: "A lobster's blood looks blue when oxygenated because it uses a copper-based oxygen-carrying protein.", factSourceURL: "https://www.britannica.com/animal/lobster"),
                Animal(id: "reindeer", name: "reindeer", imageName: "animal-reindeer", funFact: "Unlike most deer, female reindeer can grow antlers too.", factSourceURL: "https://www.britannica.com/animal/reindeer"),
                Animal(id: "alligator", name: "alligator", imageName: "animal-alligator", funFact: "American alligators make deep, booming bellows, especially during the breeding season.", factSourceURL: "https://www.britannica.com/animal/alligator"),
                Animal(id: "armadillo", name: "armadillo", imageName: "animal-armadillo", funFact: "An armadillo's armor is made of bony plates covered by tough scales.", factSourceURL: "https://www.britannica.com/animal/armadillo", imageCredit: "Tom Friedel / birdphotos.com", imageSourceURL: "http://www.birdphotos.com", imageLicense: "CC BY 3.0", imageLicenseURL: "https://creativecommons.org/licenses/by/3.0/"),
            ]
        case .insane:
            return [
                Animal(id: "chimpanzee", name: "chimpanzee", imageName: "animal-chimpanzee", funFact: "Some chimpanzees use sticks to pull termites from their mounds.", factSourceURL: "https://www.britannica.com/animal/chimpanzee"),
                Animal(id: "orangutan", name: "orangutan", imageName: "animal-orangutan", funFact: "Orangutans build nests in trees to sleep in, often making a fresh one each night.", factSourceURL: "https://www.britannica.com/animal/orangutan"),
                Animal(id: "platypus", name: "platypus", imageName: "animal-platypus", funFact: "The platypus is a mammal that lays eggs; males also have venomous spurs on their hind legs.", factSourceURL: "https://www.britannica.com/animal/platypus"),
                Animal(id: "axolotl", name: "axolotl", imageName: "animal-axolotl", funFact: "Axolotls can regrow lost limbs and repair some other damaged tissues.", factSourceURL: "https://www.britannica.com/animal/axolotl", imageCredit: "Beardsley Zoo", imageSourceURL: "https://beardsleyzoo.org/plan-your-visit/animals/axolotl/"),
                Animal(id: "echidna", name: "echidna", imageName: "animal-echidna", funFact: "Echidnas are egg-laying mammals, a rare group called monotremes.", factSourceURL: "https://www.britannica.com/animal/echidna"),
                Animal(id: "narwhal", name: "narwhal", imageName: "animal-narwhal", funFact: "A narwhal's long tusk is actually an elongated tooth, usually the left upper canine.", factSourceURL: "https://www.britannica.com/animal/narwhal"),
                Animal(id: "ostrich", name: "ostrich", imageName: "animal-ostrich", funFact: "The ostrich is the largest living bird, but it cannot fly.", factSourceURL: "https://www.britannica.com/animal/ostrich"),
                Animal(id: "wildebeest", name: "wildebeest", imageName: "animal-wildebeest", funFact: "Some wildebeest populations make huge seasonal migrations across the Serengeti.", factSourceURL: "https://www.britannica.com/animal/wildebeest", imageCredit: "Chris Eason / Wikimedia Commons", imageSourceURL: "https://a-z-animals.com/animals/wildebeest/", imageLicense: "CC BY 2.0", imageLicenseURL: "https://creativecommons.org/licenses/by/2.0/"),
                Animal(id: "cockatoo", name: "cockatoo", imageName: "animal-cockatoo", funFact: "A cockatoo can raise or lower its head crest.", factSourceURL: "https://www.britannica.com/animal/cockatoo"),
                Animal(id: "dinosaur", name: "dinosaur", imageName: "animal-dinosaur", funFact: "A T. rex weighed about six tons, but its brain weighed less than a pound.", factSourceURL: "https://www.scientificamerican.com/article/how-did-dinosaurs-see-smell-hear-and-move/", imageCredit: "Beth Zaiken / Scientific American", imageSourceURL: "https://www.scientificamerican.com/article/how-did-dinosaurs-see-smell-hear-and-move/"),
                Animal(id: "seahorse", name: "seahorse", imageName: "animal-seahorse", funFact: "In seahorses, the male carries developing eggs in a pouch until they hatch.", factSourceURL: "https://www.britannica.com/animal/sea-horse"),
                Animal(id: "salamander", name: "salamander", imageName: "animal-salamander", funFact: "Some salamanders can regrow a lost limb.", factSourceURL: "https://www.britannica.com/animal/salamander"),
                Animal(id: "chameleon", name: "chameleon", imageName: "animal-chameleon", funFact: "A chameleon's eyes can move independently, letting it look in two directions at once.", factSourceURL: "https://www.britannica.com/animal/chameleon"),
                Animal(id: "meerkat", name: "meerkat", imageName: "animal-meerkat", funFact: "Meerkats take turns standing guard and give alarm calls when danger approaches.", factSourceURL: "https://www.britannica.com/animal/meerkat", imageCredit: "Hans Hillewaert / Wikimedia Commons", imageSourceURL: "https://commons.wikimedia.org/wiki/File:Meerkat_%28Suricata_suricatta%29.jpg", imageLicense: "CC BY-SA 4.0", imageLicenseURL: "https://creativecommons.org/licenses/by-sa/4.0/"),
                Animal(id: "coelacanth", name: "coelacanth", imageName: "animal-coelacanth", funFact: "Living coelacanths were discovered in 1938, after the group was known only from fossils.", factSourceURL: "https://www.britannica.com/animal/coelacanth")
            ]
        }
    }
}

import UIKit

struct Engineer : Equatable {
    var name: String
    var role: String
    var defualtImageName: String
    var quickStats: QuickStats
    var questions: [Question]
    var profileImage = UIImage(named: "icon_profile")

    static func == (lhs: Engineer, rhs: Engineer) -> Bool {
        lhs.name == rhs.name
    }
}

struct QuickStats {
    var years: Int
    var coffees: Int
    var bugs: Int
}

extension Engineer {
    static func testingData() -> [Engineer] {
        return [
            Engineer(name: "Reenen",
                     role: "Dev manager",
                     defualtImageName: "",
                     quickStats: QuickStats(years: 6, coffees: 5400, bugs: 1800),
                     questions: [
                        MainQuestions.questionOne(answer: Answer(text: "6am", index: 0)),
                        MainQuestions.questionTwo(answer: Answer(text: "10 to 15 years old", index: 1)),
                        MainQuestions.questionThree(answer: Answer(text: "Python", index: 0)),
                        MainQuestions.questionFour(answer: Answer(text: "Every few months", index: 0)),
                        MainQuestions.questionFive(answer: Answer(text: "Watch or read a tutorial", index: 3))
                     ]),

            Engineer(name: "Wilmar",
                     role: "Head of Engineering",
                     defualtImageName: "",
                     quickStats: QuickStats(years: 15, coffees: 4000, bugs: 4000),
                     questions: [
                        MainQuestions.questionOne(answer: Answer(text: "midnight", index: 3)),
                        MainQuestions.questionTwo(answer: Answer(text: "10 to 15 years old", index: 1)),
                        MainQuestions.questionThree(answer: Answer(text: "Python", index: 0)),
                        MainQuestions.questionFour(answer: Answer(text: "Every few months", index: 0)),
                        MainQuestions.questionFive(answer: Answer(text: "Call a coworker or friend", index: 2))
                     ]),

            Engineer(name: "Eben",
                     role: "Head of Testing",
                     defualtImageName: "",
                     quickStats: QuickStats(years: 14, coffees: 1000, bugs: 100),
                     questions: [
                        MainQuestions.questionOne(answer: Answer(text: "midnight", index: 3)),
                        MainQuestions.questionTwo(answer: Answer(text: "10 to 15 years old", index: 0)),
                        MainQuestions.questionThree(answer: Answer(text: "Kotlin", index: 1)),
                        MainQuestions.questionFour(answer: Answer(text: "Every few months", index: 0)),
                        MainQuestions.questionFive(answer: Answer(text: "Watch or read a tutorial", index: 3))
                     ]),

            Engineer(name: "Stefan",
                     role: "Senior dev",
                     defualtImageName: "",
                     quickStats: QuickStats(years: 7, coffees: 9000, bugs: 700),
                     questions: [
                        MainQuestions.questionOne(answer: Answer(text: "6am", index: 0)),
                        MainQuestions.questionTwo(answer: Answer(text: "21 to 25 years old", index: 3)),
                        MainQuestions.questionThree(answer: Answer(text: "Ruby", index: 3)),
                        MainQuestions.questionFour(answer: Answer(text: "Once a year", index: 1)),
                        MainQuestions.questionFive(answer: Answer(text: "Visit Stack Overflow", index: 0))
                     ]),

            Engineer(name: "Brandon",
                     role: "Senior dev",
                     defualtImageName: "",
                     quickStats: QuickStats(years: 9, coffees: 99999, bugs: 99999),
                     questions: [
                        MainQuestions.questionOne(answer: Answer(text: "6am", index: 0)),
                        MainQuestions.questionTwo(answer: Answer(text: "10 to 15 years old", index: 1)),
                        MainQuestions.questionThree(answer: Answer(text: "C++", index: 5)),
                        MainQuestions.questionFour(answer: Answer(text: "Every few months", index: 0)),
                        MainQuestions.questionFive(answer: Answer(text: "Visit Stack Overflow", index: 0))
                     ]),

            Engineer(name: "Henri",
                     role: "Senior dev",
                     defualtImageName: "",
                     quickStats: QuickStats(years: 10, coffees: 1800, bugs: 1000),
                     questions: [
                        MainQuestions.questionOne(answer: Answer(text: "6am", index: 0)),
                        MainQuestions.questionTwo(answer: Answer(text: "10 to 15 years old", index: 0)),
                        MainQuestions.questionThree(answer: Answer(text: "Rust", index: 6)),
                        MainQuestions.questionFour(answer: Answer(text: "Every few months", index: 0)),
                        MainQuestions.questionFive(answer: Answer(text: "Go down a google rabbit hole", index: 4))
                     ])
        ]
    }
}

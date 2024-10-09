import XCTest
@testable import About_You

class About_YouTests: XCTestCase {

    // Steve did not really know about tests...
    // Maybe you can show him by testing the results calculations?

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testCanCreateEngineer() {
        // Test engineer creation with valid input
        let engineer = createEngineer(name: "Tom", years: 2, coffees: 5400, bugs: 20)
        XCTAssertNotNil(engineer, "Engineer should not be nil")
    }

    func testEngineerOrderingByYears() {
        // Test ordering engineers by years
        let engineersArray = createEngineersArray()
        let expectedOrder = [engineersArray[0], engineersArray[2], engineersArray[4], engineersArray[1], engineersArray[3]]

        let orderedByYears = engineersArray.sorted { $0.quickStats.years < $1.quickStats.years }
        XCTAssertEqual(expectedOrder, orderedByYears, "Engineers should be sorted by years correctly")
    }

    func testEngineerOrderingByCoffees() {
        // Test ordering engineers by coffees
        let engineersArray = createEngineersArray()
        let expectedOrder = [engineersArray[1], engineersArray[4], engineersArray[2], engineersArray[3], engineersArray[0]]

        let orderedByCoffees = engineersArray.sorted { $0.quickStats.coffees < $1.quickStats.coffees }
        XCTAssertEqual(expectedOrder, orderedByCoffees, "Engineers should be sorted by coffees correctly")
    }

    func testEngineerOrderingByBugs() {
        // Test ordering engineers by bugs
        let engineersArray = createEngineersArray()
        let expectedOrder = [engineersArray[3], engineersArray[1], engineersArray[0], engineersArray[2], engineersArray[4]]

        let orderedByBugs = engineersArray.sorted { $0.quickStats.bugs < $1.quickStats.bugs }
        XCTAssertEqual(expectedOrder, orderedByBugs, "Engineers should be sorted by bugs correctly")
    }

    func testCanCreateEngineerWithEmptyValues() {
        let engineer = Engineer(name: "", role: "", defualtImageName: "", quickStats: QuickStats(years: 0, coffees: 0, bugs: 0), questions: [])
        XCTAssertNotNil(engineer)
        XCTAssertEqual(engineer.name, "")
        XCTAssertEqual(engineer.role, "")
        XCTAssertEqual(engineer.quickStats.years, 0)
        XCTAssertEqual(engineer.quickStats.coffees, 0)
        XCTAssertEqual(engineer.quickStats.bugs, 0)
    }

    func testUpdateEngineerQuickStats() {
        var engineer = createEngineer(name: "Mark", years: 4, coffees: 1200, bugs: 50)

        // Update quick stats
        engineer.quickStats = QuickStats(years: 5, coffees: 1500, bugs: 100)

        XCTAssertEqual(engineer.quickStats.years, 5)
        XCTAssertEqual(engineer.quickStats.coffees, 1500)
        XCTAssertEqual(engineer.quickStats.bugs, 100)
    }

    // MARK: - Helper Methods

    /// Helper method to create an Engineer instance
    private func createEngineer(name: String, years: Int, coffees: Int, bugs: Int) -> Engineer {
        return Engineer(
            name: name,
            role: "Junior Developer",
            defualtImageName: "",
            quickStats: QuickStats(years: years, coffees: coffees, bugs: bugs),
            questions: [
                MainQuestions.questionOne(answer: Answer(text: "6am", index: 0)),
                MainQuestions.questionTwo(answer: Answer(text: "10 to 15 years old", index: 1)),
                MainQuestions.questionThree(answer: Answer(text: "Python", index: 0)),
                MainQuestions.questionFour(answer: Answer(text: "Every few months", index: 0)),
                MainQuestions.questionFive(answer: Answer(text: "Watch or read a tutorial", index: 3))
            ]
        )
    }

    /// Helper method to create an array of Engineer instances
    private func createEngineersArray() -> [Engineer] {
        return [
            createEngineer(name: "Tom", years: 2, coffees: 5400, bugs: 20),
            createEngineer(name: "John", years: 15, coffees: 2, bugs: 10),
            createEngineer(name: "Tomas", years: 3, coffees: 300, bugs: 180),
            createEngineer(name: "Mary", years: 18, coffees: 500, bugs: 2),
            createEngineer(name: "Simon", years: 8, coffees: 10, bugs: 1800)
        ]
    }
}


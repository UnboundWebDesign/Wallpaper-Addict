import XCTest
import Combine
@testable import WallpaperAddict

class UnsplashAPITests: XCTestCase {
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = []
    }

    override func tearDown() {
        cancellables = nil
        super.tearDown()
    }

    
    func testFetchLatestImages() {
        let expectation = self.expectation(description: "Fetch latest images")
        var responseImages: [UnsplashImage]?
        var responseError: Error?

        UnsplashAPI.shared.fetchLatestImages()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    responseError = error
                    expectation.fulfill()  // Ensure the expectation is fulfilled on error
                }
            }, receiveValue: { images in
                responseImages = images
                expectation.fulfill()  // Ensure the expectation is fulfilled on success
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 10, handler: nil)

        XCTAssertNotNil(responseImages, "Images should not be nil")
        XCTAssertNil(responseError, "Error should be nil")
        XCTAssertNotNil(responseImages?.count, "Image count should not be nil")
        XCTAssertTrue(responseImages?.count ?? 0 > 0, "There should be at least one image")
    }
}

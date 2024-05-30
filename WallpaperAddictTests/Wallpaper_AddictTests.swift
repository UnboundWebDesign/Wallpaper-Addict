// Unit Tests Example
import XCTest
@testable import WallpaperAddict

class WallpaperAddictTests: XCTestCase {

    func testFetchLatestImages() {
        let expectation = XCTestExpectation(description: "Download latest images")
        let viewModel = ImageViewModel()

        viewModel.$latestImages
            .sink { images in
                if !images.isEmpty {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        viewModel.fetchLatestImages()

        wait(for: [expectation], timeout: 10.0)
    }
}

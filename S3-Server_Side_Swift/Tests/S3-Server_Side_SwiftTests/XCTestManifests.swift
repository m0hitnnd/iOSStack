import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(S3_Server_Side_SwiftTests.allTests),
    ]
}
#endif

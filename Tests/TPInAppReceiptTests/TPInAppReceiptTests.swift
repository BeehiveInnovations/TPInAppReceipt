import Foundation
import XCTest
@testable import TPInAppReceipt

final class TPInAppReceiptTests: XCTestCase {
  func testBundledCertificatesAreAvailable() throws {
    let productionCertificatePath = try XCTUnwrap(
      Bundle.lookUp(forResource: "AppleIncRootCertificate", ofType: "cer")
    )
    let storeKitTestCertificatePath = try XCTUnwrap(
      Bundle.lookUp(forResource: "StoreKitTestCertificate", ofType: "cer")
    )

    let productionCertificate = try Data(contentsOf: URL(fileURLWithPath: productionCertificatePath))
    let storeKitTestCertificate = try Data(contentsOf: URL(fileURLWithPath: storeKitTestCertificatePath))

    XCTAssertFalse(productionCertificate.isEmpty)
    XCTAssertFalse(storeKitTestCertificate.isEmpty)
  }

	func testCrashReceipts() {
		var r = try? InAppReceipt(receiptData: noOriginalPurchaseDateCrashReceipt)
	}
	
	func testNewReceipt() {
		self.measure {
			let r = try! InAppReceipt(receiptData: newReceipt)
			print(r.creationDate)
		}
		
	}
	
	func testLegacyReceipt() {
		self.measure {
			let r = try! InAppReceipt(receiptData: legacyReceipt)
		}
		
	}
	
    static var allTests = [
        ("testNewReceipt", testNewReceipt),
        ("testBundledCertificatesAreAvailable", testBundledCertificatesAreAvailable)
    ]
}

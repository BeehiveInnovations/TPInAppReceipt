import XCTest
@testable import TPInAppReceipt

/// Protects the inclusive purchase date and exclusive subscription expiry boundary.
final class InAppPurchaseDateBoundaryTests: XCTestCase {
  func testActiveSubscriptionIncludesPurchaseDateAndExcludesExpiry() {
    var purchase = InAppPurchase(
      productIdentifier: "subscription",
      transactionIdentifier: "transaction",
      originalTransactionIdentifier: "original",
      purchaseDate: Date(timeIntervalSinceReferenceDate: 100)
    )
    purchase.subscriptionExpirationDate = Date(timeIntervalSinceReferenceDate: 200)

    XCTAssertFalse(purchase.isActiveAutoRenewableSubscription(forDate: Date(timeIntervalSinceReferenceDate: 99)))
    XCTAssertTrue(purchase.isActiveAutoRenewableSubscription(forDate: Date(timeIntervalSinceReferenceDate: 100)))
    XCTAssertTrue(purchase.isActiveAutoRenewableSubscription(forDate: Date(timeIntervalSinceReferenceDate: 150)))
    XCTAssertFalse(purchase.isActiveAutoRenewableSubscription(forDate: Date(timeIntervalSinceReferenceDate: 200)))

    purchase.cancellationDate = Date(timeIntervalSinceReferenceDate: 120)
    XCTAssertFalse(purchase.isActiveAutoRenewableSubscription(forDate: Date(timeIntervalSinceReferenceDate: 150)))
  }
}

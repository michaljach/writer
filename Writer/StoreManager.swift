//
//  StoreManager.swift
//  Writer
//
//  Created by Michal Jach on 11/02/2021.
//

import Foundation
import StoreKit

class StoreManager: NSObject, ObservableObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    //FETCH PRODUCTS
    var request: SKProductsRequest!
    
    @Published var myProducts = [SKProduct]()
    var restoredCallback: (() -> Void)?
    var purchasedCallback: (() -> Void)?
    
    func getProducts(productIDs: [String]) {
        print("Start requesting products ...")
        let request = SKProductsRequest(productIdentifiers: Set(productIDs))
        request.delegate = self
        request.start()
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("Did receive response")
        
        if !response.products.isEmpty {
            for fetchedProduct in response.products {
                DispatchQueue.main.async {
                    self.myProducts.append(fetchedProduct)
                }
            }
        }
        
        for invalidIdentifier in response.invalidProductIdentifiers {
            print("Invalid identifiers found: \(invalidIdentifier)")
        }
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Request did fail: \(error)")
    }
    
    //HANDLE TRANSACTIONS
    @Published var transactionState: SKPaymentTransactionState?
    
    func purchaseProduct(product: SKProduct, callback: @escaping () -> Void) {
        self.purchasedCallback = callback
        if SKPaymentQueue.canMakePayments() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
        } else {
            print("User can't make payment.")
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        if let restoredCallback = self.restoredCallback {
            restoredCallback()
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                transactionState = .purchasing
            case .purchased:
                UserDefaults.standard.setValue(true, forKey: transaction.payment.productIdentifier)
                queue.finishTransaction(transaction)
                transactionState = .purchased
                if let purchasedCallback = self.purchasedCallback {
                    purchasedCallback()
                }
            case .restored:
                UserDefaults.standard.setValue(true, forKey: transaction.payment.productIdentifier)
                queue.finishTransaction(transaction)
                transactionState = .restored
                if let restoredCallback = self.restoredCallback {
                    restoredCallback()
                }
            case .failed, .deferred:
                print("Payment Queue Error: \(String(describing: transaction.error))")
                queue.finishTransaction(transaction)
                transactionState = .failed
                if let restoredCallback = self.restoredCallback {
                    restoredCallback()
                }
                if let purchasedCallback = self.purchasedCallback {
                    purchasedCallback()
                }
            default:
                queue.finishTransaction(transaction)
                if let restoredCallback = self.restoredCallback {
                    restoredCallback()
                }
                if let purchasedCallback = self.purchasedCallback {
                    purchasedCallback()
                }
            }
        }
    }
    
    func restoreProducts(callback: @escaping () -> Void) {
        print("Restoring products ...")
        self.restoredCallback = callback
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}

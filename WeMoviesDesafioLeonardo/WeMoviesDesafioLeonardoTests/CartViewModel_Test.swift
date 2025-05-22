//
//  CartViewModel_Test.swift
//  WeMoviesDesafioLeonardoTests
//
//  Created by Leonardo Mesquita Alves on 27/04/25.
//

import XCTest
@testable import WeMoviesDesafioLeonardo

@MainActor
final class CartViewModel_Test: XCTestCase {
    var sut: CartViewModel!
    var mockStorage: MockMovieStorageManager!
    let exampleItem1 = CartItem(
        id: UUID(),
        product: .init(
            id: 1,
            title: "",
            price: 15,
            image: ""
        ),
        quantity: 0,
        dateAddedToCart: nil
    )
    let exampleItem2 = CartItem(
        id: UUID(),
        product: .init(
            id: 1,
            title: "",
            price: 0,
            image: ""
        ),
        quantity: 5,
        dateAddedToCart: nil
    )
    let exampleItem3 = CartItem(
        id: UUID(),
        product: .init(
            id: 1,
            title: "",
            price: 23,
            image: ""
        ),
        quantity: 10,
        dateAddedToCart: nil
    )
    
    override func setUp() {
        super.setUp()
        mockStorage = MockMovieStorageManager()
        sut = CartViewModel(storage: mockStorage)
    }
    
    override func tearDown() {
        sut = nil
        mockStorage = nil
        super.tearDown()
    }
    
    func test_isEmpty_withEmptyCart_shouldReturnTrue() {
        //Given
        mockStorage.items = []
        
        //When
        
        //Then
        XCTAssertTrue(sut.isEmpty)
    }
    
    func test_isEmpty_withNonEmptyCartWithZeroQuantity_shouldReturnTrue() {
        //Given
        mockStorage.items = [
            exampleItem1
        ]
        
        //When
        let isEmpty = sut.cartItems.isEmpty
        
        //Then
        XCTAssertTrue(isEmpty)
    }
    
    func test_isEmpty_withNonEmptyCartWithNonZeroQuantity_shouldReturnFalse() {
        //Given
        mockStorage.items = [
            exampleItem2
        ]
        
        //When
        let isEmpty = sut.cartItems.isEmpty
        
        //Then
        XCTAssertFalse(isEmpty)
    }
    
    func test_cartItems_withItemsInCart_shouldReturnCorrectItems() {
        //Given
        let expectedItem = exampleItem2
        mockStorage.items = [expectedItem]
        
        //When
        let items = sut.cartItems
        
        //Then
        XCTAssertEqual(items.count, 1)
        XCTAssertEqual(items.first?.product.id, expectedItem.product.id)
    }
    
    func test_totalQuantity_withValidItems_shouldReturnCorrectQuantity() {
        //Given
        mockStorage.items = [
            exampleItem1,
            exampleItem2,
            exampleItem3
        ]
        
        //When
                
        //Then
        XCTAssertEqual(sut.totalQuantity, "15")
    }
    
    func test_totalQuantity_withValidItemsButStorageHavingError_shouldReturnZeroQuantity() {
        //Given
        mockStorage.apiRequestError = TestError()
        mockStorage.items = [
            exampleItem1,
            exampleItem3
        ]
        
        //When
        
        //Then
        XCTAssertEqual(sut.totalQuantity, "0")
    }
    
    func test_totalPrice_withValidItems_shouldReturnCorrectPrice() {
        //Given
        mockStorage.items = [
            exampleItem1,
            exampleItem3
        ]
        
        //When
        let priceConverted = 230.asBrazilianCurrency
        
        //Then
        XCTAssertEqual(sut.totalPrice, priceConverted)
    }
    
    func test_apiRequestError_withStorageHavingError_shouldReturnError() {
        //Given
        let expectedError = TestError()
        mockStorage.apiRequestError = expectedError
        
        //When
        let error = sut.apiRequestError
        
        //Then
        XCTAssertNotNil(error)
    }
    
    func test_apiRequestError_withStorageHavingNoError_shouldReturnNil() {
        //Given
        mockStorage.apiRequestError = nil
        
        //When
        let error = sut.apiRequestError
        
        //Then
        XCTAssertNil(error)
    }
    
    func test_removeProduct_withValidProductId_shouldCallResetQuantity() {
        //Given
        let productID = 15
        
        //When
        sut.removeProduct(with: productID)
        
        //Then
        XCTAssertEqual(mockStorage.resetQuantityCalledWithId, productID)
    }
    
    func test_decreaseQuantity_withValidProductId_shouldCallDecreaseQuantity() {
        //Given
        let productID = 15
        
        //When
        sut.decreaseQuantity(for: productID)
        
        //Then
        XCTAssertEqual(mockStorage.decreaseQuantityCalledWithId, productID)
    }
    
    func test_increaseQuantity_withValidProductId_shouldCallIncreaseQuantity() {
        //Given
        let productID = 15
        
        //When
        sut.increaseQuantity(for: productID)
        
        //Then
        XCTAssertEqual(mockStorage.increaseQuantityCalledId, productID)
    }
    
    func test_confirmPurchase_shouldCallResetAllQuantity() {
        //Given
        
        //When
        sut.confirmPurchase()
        
        //Then
        XCTAssertTrue(mockStorage.resetAllQuantityCalled)
    }
}

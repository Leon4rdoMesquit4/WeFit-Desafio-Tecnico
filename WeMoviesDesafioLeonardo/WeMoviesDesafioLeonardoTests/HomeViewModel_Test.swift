//
//  HomeViewModel_Test.swift
//  WeMoviesDesafioLeonardoTests
//
//  Created by Leonardo Mesquita Alves on 27/04/25.
//

import XCTest
@testable import WeMoviesDesafioLeonardo

@MainActor
final class HomeViewModel_Test: XCTestCase {
    var sut: HomeViewModel!
    var mockStorage: MockMovieStorageManager!
    let exampleItem1 = CartItem(
        id: UUID(),
        product: .init(
            id: 1,
            title: "",
            price: 0,
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
        quantity: 0,
        dateAddedToCart: nil
    )
    
    override func setUpWithError() throws {
        mockStorage = MockMovieStorageManager()
        sut = HomeViewModel(storage: mockStorage)
    }
    
    override func tearDownWithError() throws {
        mockStorage = nil
        sut = nil
    }
    
    func test_reloadData_withSuccessfulLoad_shouldClearApiRequestError() async {
        //Given
        mockStorage.failApiRequest = false
        mockStorage.apiRequestError = nil
        
        //When
        await sut.reloadData()
        
        //Then
        XCTAssertNil(mockStorage.apiRequestError)
        XCTAssertTrue(mockStorage.loadFromAPICalled)
    }
    
    func test_reloadData_withFailureInLoad_shouldSetApiRequestError() async {
        //Given
        mockStorage.failApiRequest = true
        mockStorage.apiRequestError = nil
        
        //When
        await sut.reloadData()
        
        //Then
        XCTAssertNotNil(mockStorage.apiRequestError)
    }
    
    func test_increaseQuantity_withValidId_shouldCallStorageIncreaseQuantity() {
        //Given
        let expectedId = 123
        
        //When
        sut.increaseQuantity(for: expectedId)
        
        //Then
        XCTAssertEqual(mockStorage.increaseQuantityCalledId, expectedId)
    }
    
    func test_storageIsEmpty_withEmptyItems_shouldReturnTrue() {
        //Given
        mockStorage.items = []
        
        //When
        
        //Then
        XCTAssertTrue(sut.storageIsEmpty())
    }
    
    func test_storageIsEmpty_withNonEmptyItems_shouldReturnFalse() {
        //Given
        mockStorage.items = [
            exampleItem1,
            exampleItem2
        ]
        
        //When
        
        //Then
        XCTAssertFalse(sut.storageIsEmpty())
    }
    
    func test_productsIndices_withItems_shouldReturnCorrectRange() {
        //Given
        mockStorage.items = [
            exampleItem1,
            exampleItem2
        ]
        
        //When
        
        //Then
        XCTAssertEqual(sut.productsIndices(), 0..<2)
    }
    
    func test_productId_withValidIndex_shouldReturnCorrectId() {
        //Given
        let expectedId = 1
        mockStorage.items = [
            CartItem(id: UUID(), product: .init(id: expectedId, title: "", price: 0, image: ""), quantity: 0, dateAddedToCart: nil)
        ]
        
        //When
        
        //Then
        XCTAssertEqual(sut.productId(at: 0), expectedId)
    }
    
    func test_product_withValidIndex_shouldReturnCorrectCartItem() {
        //Given
        mockStorage.items = [
            exampleItem1,
            exampleItem2
        ]
        
        //When
        let product = sut.product(at: 0)
        
        //Then
        XCTAssertEqual(product.product.id, exampleItem1.product.id)
        XCTAssertEqual(product.quantity, exampleItem1.quantity)
    }
    
    func test_apiRequestError_withStorageHavingError_shouldReturnError() {
        //Given
        let expectedError = TestError()
        mockStorage.apiRequestError = expectedError
        
        //When
        
        //Then
        XCTAssertNotNil(sut.apiRequestError)
    }
    
    func test_apiRequestError_withStorageHavingNoError_shouldReturnNil() {
        //Given
        mockStorage.apiRequestError = nil
        
        //When
        
        //Then
        XCTAssertNil(sut.apiRequestError)
    }
}

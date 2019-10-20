//
//  ApplicasteriOSTests.swift
//  ApplicasteriOSTests
//
//  Created by Gio Lomsa on 10/10/19.
//  Copyright © 2019 Giorgi Lomsadze. All rights reserved.
//

import XCTest
@testable import ApplicasteriOS

class ApplicasteriOSTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMainURLSessionMethodForApplicastercom() {
        
        let expectation = XCTestExpectation(description: "Get root items")
        let networking = HTTPLayer()
        
        networking.request(at: .applicastercom) { (data, response, error) in
            
            XCTAssertNotNil(data, "Main URLSession test failed")
            if let response = response as? HTTPURLResponse{
                XCTAssert(response.statusCode.isSuccessHTTPCode, "Main URLSession response status isn't success")
            }else{
                XCTAssert(false, "Main URLSession response failed")
            }
            XCTAssertNil(error, "Main URLSession error")
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testMainURLSessionMethodForAWS() {
        
        let expectation = XCTestExpectation(description: "Get root items")
        let networking = HTTPLayer()
        
        networking.request(at: .aws) { (data, response, error) in
            
            XCTAssertNotNil(data, "Main URLSession test failed")
            if let response = response as? HTTPURLResponse{
                XCTAssert(response.statusCode.isSuccessHTTPCode, "Main URLSession response status isn't success")
            }else{
                XCTAssert(false, "Main URLSession response failed")
            }
            XCTAssertNil(error, "Main URLSession error")
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testMainUrlSessionMethodForUrl(){
        
        let expectation = XCTestExpectation(description: "Get image from url")
        
        let urlString = "https://www.applicaster.com/hubfs/191524733@2x_resized.png"
        let networking = HTTPLayer()
        networking.request(at: .fromUrl(urlString)) { (data, response, error) in
            
            XCTAssertNotNil(data, "Main URLSession test failed")
            
            if let response = response as? HTTPURLResponse{
                XCTAssert(response.statusCode.isSuccessHTTPCode, "Main URLSession response status isn't success")
            }else{
                XCTAssert(false, "Main URLSession response failed")
            }
            
            XCTAssertNil(error, "Main URLSession error")
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testNetworkLayerLoadingMethodForApplicastercom(){
    
    let expectation = XCTestExpectation(description: "load root items")
    
    let httpLayer = HTTPLayer()
    let networking = APIClient(httpLayer: httpLayer)
    
    networking.getPostsFromApplicastercom { (result) in
    switch result{
    case .failure(_):
    XCTAssert(false, "Error while loading root Items from network layer")
    case .success(let itemsDictionary):
    XCTAssert(!itemsDictionary.isEmpty, "Loaded root Items dictionary is empty")
    }
    expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 10.0)
    }
    
    func testNetworkLayerLoadingMethodForAWS(){
        
        let expectation = XCTestExpectation(description: "load root items")
        
        let httpLayer = HTTPLayer()
        let networking = APIClient(httpLayer: httpLayer)
        
        networking.getPostsFromAWS { (result) in
            switch result{
            case .failure(_):
                XCTAssert(false, "Error while loading root Items from network layer")
            case .success(let itemsDictionary):
                XCTAssert(!itemsDictionary.isEmpty, "Loaded root Items dictionary is empty")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testNetworkLayerLoadingMethodForUrlString(){
        
        
        let expectation = XCTestExpectation(description: "Get image from url")
        
        let urlString = "https://www.applicaster.com/hubfs/191524733@2x_resized.png"
        let networking = HTTPLayer()
        networking.request(at: .fromUrl(urlString)) { (data, response, error) in
            
            XCTAssertNotNil(data, "Main URLSession test failed")
            
            if let response = response as? HTTPURLResponse{
                XCTAssert(response.statusCode.isSuccessHTTPCode, "Main URLSession response status isn't success")
            }else{
                XCTAssert(false, "Main URLSession response failed")
            }
            
            XCTAssertNil(error, "Main URLSession error")
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testLoadingPostsFromServerOnViewModelLayer(){
        let viewmodel = RootViewModel()
        viewmodel.loadPosts()

        XCTAssertNotEqual(viewmodel.unfilteredPosts.count, 0, "loaded posts are empty")
        
    }
    
    func testImageLoadingFromUrlStringOnViewModelLayer(){
        let urlString = "https://www.applicaster.com/hubfs/191524733@2x_resized.png"
        let viewmodel = RootViewModel()
        
        let expectation = XCTestExpectation(description: "Get image from url")
        
        viewmodel.loadImageFromUrl(for: urlString) { (image) in
            XCTAssertNotNil(image, "Main URLSession test failed")
            XCTAssertNotEqual(image, UIImage())
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
}

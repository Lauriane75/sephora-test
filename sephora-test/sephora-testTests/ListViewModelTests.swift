//
//  ListViewModelTests.swift
//  sephora-testTests
//
//  Created by Lau on 28/06/2021.
//

import XCTest
import RxSwift
import RxCocoa
@testable import sephora_test

class ListViewModelTests: XCTestCase {
    
    private var disposeBag: DisposeBag!
    private var viewDidLoad: PublishSubject<Void>!
    private var didSelectItem: PublishSubject<Void>!
    
    override func setUp() {
        super.setUp()
        
        disposeBag = DisposeBag()
        viewDidLoad = PublishSubject<Void>()
        didSelectItem = PublishSubject<Void>()
    }
    
    func test_ViewDidLoad_returnsProducts() {
//        let expectation = self.expectation(description: "Return products data")
    
    
    }
    

   
}

//
//  OperationQueueMock.swift
//  RevolutTestTests
//
//  Created by Gregory Oberemkov on 20/01/2019.
//  Copyright © 2019 Gregory Oberemkov. All rights reserved.
//

import Foundation
@testable import RevolutTest

final class OperationQueueMock: OperationQueue {
    
    var addOperationCounter = 0
    var isCancel = false
    
    // swiftlint:disable identifier_name
    override func addOperation(_ op: Operation) {
        super.addOperation(op)
        isCancel = false
        addOperationCounter += 1
    }
    
    override func cancelAllOperations() {
        super.cancelAllOperations()
        isCancel = true
    }
    
}

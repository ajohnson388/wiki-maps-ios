//
//  WorkerRequest.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/6/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

/**
    If threads are set to nil, no dispatch will be made.
    This is useful for chaining workers on the same thread.
 */
protocol WorkerRequest {
    var workerThread: DispatchQueue? { get set }
    var responseThread: DispatchQueue? { get set }
}

extension WorkerRequest {
    
    func asyncResponse<T>(_ response: T, handler: @escaping (T) -> Void) {
        let executeResponse = { handler(response) }
        guard let thread = responseThread else {
            executeResponse()
            return
        }
        thread.async(execute: executeResponse)
    }
    
    func asyncRequest(_ handler: @escaping () -> Void) {
        guard let thread = workerThread else {
            handler()
            return
        }
        thread.async(execute: handler)
    }
}

//
//  FetchLocalDataset.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/19/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

struct FetchLocalDataset {
    
    struct Request: WorkerRequest {
        var url: URL
        var workerThread: DispatchQueue? = DispatchQueue.global(qos: .background)
        var responseThread: DispatchQueue? = nil
    }
    
    enum Response {
        case success(DataSet)
        case error(Error)
    }
    
    static func fetchLocalDataSet(withRequest request: Request,
                                  responseHandler: @escaping (Response) -> Void) {
        let fetchJsonRequest = FetchJsonWorker.Request(dataSource: .local,
                                              url: request.url,
                                              workerThread: request.workerThread,
                                              responseThread: request.responseThread)
        FetchJsonWorker.fetchJson(withRequest:fetchJsonRequest) { fetchJsonResponse in
            
            let response: Response
            defer {
                request.asyncResponse(response, handler: responseHandler)
            }
            
            switch fetchJsonResponse {
            case .success(let json):
                guard let dataSet = DataSet(json: json) else {
                    let error = GeneralError("Failed to conver the data set from json")
                    response = Response.error(error)
                    return
                }
                response = Response.success(dataSet)
            case .error(let error):
                response = Response.error(error)
            }
        }
    }
}

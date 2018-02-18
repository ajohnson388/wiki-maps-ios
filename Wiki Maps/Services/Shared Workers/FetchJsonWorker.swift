//
//  FetchJsonWorker.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/10/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

struct FetchJsonWorker {
    
    struct Request: WorkerRequest  {
        enum DataSource { case local, remote }
        var dataSource: DataSource
        var url: URL
        var workerThread: DispatchQueue? = DispatchQueue.global(qos: .background)
        var responseThread: DispatchQueue? = nil
    }
    
    enum Response {
        case success(json: [String: Any])
        case error(error: Error)
    }
    
    static func fetchJson(withRequest request: Request,
                          responseHandler: @escaping (Response) -> Void) {
        request.asyncRequest {
            switch request.dataSource {
            case .local:
                handleLocalJsonFetch(withRequest: request, responseHandler: responseHandler)
            case .remote:
                let responseHandler = handleRemoteJsonFetch(withRequest: request,
                                                         responseHandler: responseHandler)
                let task = URLSession.shared.dataTask(with: request.url, completionHandler: responseHandler)
                task.resume()
            }
        }
    }
    
    private static func handleRemoteJsonFetch(withRequest request: Request,
                                              responseHandler: @escaping (Response) -> Void)
        -> (Data?, URLResponse?, Error?) -> Void {
            return { data, response, error in
                // Check for errors, if any exit early
                if let error = error {
                    request.asyncResponse(Response.error(error: error),
                                          handler: responseHandler)
                    return
                }
                
                
                // Assert the data exists
                guard let data = data else {
                    let error = GeneralError("Payload is missing")
                    request.asyncResponse(Response.error(error: error),
                                          handler: responseHandler)
                    return
                }
                
                // Convert the data to json
                do {
                    let json = try JSONSerialization.jsonObject(with: data,
                                                                options: []) as? [String: Any]
                    request.asyncResponse(Response.success(json: json ?? [:]),
                                          handler: responseHandler)
                } catch {
                    request.asyncResponse(Response.error(error: error),
                                          handler: responseHandler)
                }
            }
    }
    
    private static func handleLocalJsonFetch(withRequest request: Request,
                                             responseHandler: @escaping (Response) -> Void) {
        guard let fileName = Bundle.main.path(forResource: request.url.absoluteString, ofType: "json"),
            let fileUrl = URL(string: fileName) else {
                
                let error = GeneralError("File not found")
                request.asyncResponse(Response.error(error: error), handler: responseHandler)
                return
        }
        
        do {
            let data = try Data(contentsOf: fileUrl)
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            request.asyncResponse(Response.success(json: json ?? [:]), handler: responseHandler)
        } catch {
            let error = GeneralError("Failed to get contents of file: \(fileName)")
            request.asyncResponse(Response.error(error: error), handler: responseHandler)
        }
    }
}

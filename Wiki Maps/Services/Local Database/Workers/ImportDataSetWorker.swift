//
//  ImportDataSetWorker.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/4/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation
import Alamofire

struct ImportDataSetWorker {
    
    struct Request {
        var url: URL
        var responseDispatchQueue = DispatchQueue.main
    }
    
    enum Response {
        case success
        case error(error: Error)
    }
    
    static func importDataSet(withRequest request: Request,
                              responseHandler: @escaping (Response) -> Void) {

        // Fetch from github user content url
        let networkFetch = URLSession.shared.dataTask(with: request.url) {
            data, response, error in
            
            var callbackResponse = Response.success
            defer {
                request.responseDispatchQueue.async {
                    responseHandler(callbackResponse)
                }
            }
            
            // Check for errors, if any exit early
            if let error = error {
                callbackResponse = Response.error(error: error)
                return
            }
            
            // Assert the data exists
            guard let data = data else {
                let error = GeneralError(localizedDescription: "Payload is missing")
                callbackResponse = Response.error(error: error)
                return
            }
            
            // Convert the data to json
            
        }
        
        // Then import into database
    }
}

//
//  APIRequest.swift
///   Indrajit
//
//  Created by Indrajit Chavda on 18/12/20.
//

import Foundation

/// API service methods.
protocol APIRequestDelegates {
    
    /// This method request server to return needed response.
    /// - Parameters:
    ///   - url: URL pointing to server.
    ///   - completionHandler: Returns either success or failure.
    func request(url:URL,completionHandler:@escaping (Result<Data, Error>?)->())

}

/// This class helps to call server APIs.
class APIRequest:APIRequestDelegates {
    
    /// This method request server to return needed response.
    /// - Parameters:
    ///   - url: URL pointing to server.
    ///   - decodable: Decodable class which will be serialised automatically.
    ///   - completionHandler: Returns either success or failure.
    func request(url:URL,completionHandler:@escaping (Result<Data, Error>?)->()){
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {

                if let data = data{
                    completionHandler(.success(data))
                    return
                }
                
                if let error = error{
                    completionHandler(.failure(error))
                }else{
                    completionHandler(.failure(NSError(domain: "general.error.someting_wrong".localise, code: 100, userInfo: nil) as Error))
                }
            }
            
        }.resume()
        
    }
}


//
//  APIClient.swift
//  Rx Swift Sample
//
//  Created by JETS Mobil Lab -  on 5/29/19.
//  Copyright © 2019 Abd elrhman. All rights reserved.
//

import Foundation
import Alamofire

public enum HTTPServerMethod : String{
    case options = "OPTIONS"
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    case trace = "TRACE"
    case connect = "CONNECT"
}

class APIClient  {
    
    
    
    func executeAPICall(url : String , httpMethod : HTTPServerMethod , parameters : [String :Any]? ,headers : [String : String]? , successHandler : @escaping (Data) -> Void  , failureHandler : @escaping (Error) ->Void  ){
        
        guard let apiURL = URL (string: url )else {return}
        if let isReachable = NetworkReachabilityManager(host: apiURL.host ?? "")?.isReachable,
            isReachable == true {
            
            Alamofire.request(apiURL, method: HTTPMethod (rawValue: httpMethod.rawValue) ?? .get, parameters: parameters , headers: headers)
                .responseData { (dataResponse) in
                    if let error = dataResponse.error {
                        failureHandler(error)
                    }
                    else if let data = dataResponse.data{
                        successHandler(data)
                    }
            }
            }
        else {
            let error  = NSError(domain: NSURLErrorDomain, code: URLError.notConnectedToInternet.rawValue, userInfo: nil )as Error
            failureHandler(error)
        }
        
    }
    func executeJSONAPICall(url : String , httpMethod : HTTPServerMethod , parameters : [String :Any]? ,headers : [String : String]? , successHandler : @escaping ([String : Any]) -> Void  , failureHandler : @escaping (Error) ->Void  ){
        
        guard let apiURL = URL (string: url )else {return}
        if let isReachable = NetworkReachabilityManager(host: apiURL.host ?? "")?.isReachable,
            isReachable == true {
            
            Alamofire.request(apiURL, method: HTTPMethod (rawValue: httpMethod.rawValue) ?? .get, parameters: parameters , headers: headers)
                
                .responseJSON(completionHandler: { (jsonResponse) in
                    if let error = jsonResponse.error {
                        failureHandler(error)
                    }
                    else if let json :[String : Any] = jsonResponse.result.value
                    as? [String : Any] {
                        successHandler(json)
                    }
                })
        }
        else {
            let error  = NSError(domain: NSURLErrorDomain, code: URLError.notConnectedToInternet.rawValue, userInfo: nil )as Error
            failureHandler(error)
        }
        
    }
    
    
}

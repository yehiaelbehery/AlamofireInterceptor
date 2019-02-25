//
//  InterceptorDataRequest.swift
//  Test
//
//  Created by Yehia Elbehery on 2/6/19.
//  Copyright © 2019 Nehal Elsawaf. All rights reserved.
//

import Alamofire

public class InterceptorDataRequest {
    var request: DataRequest?
    
    var url: URLConvertible?
    var method: HTTPMethod?
    var parameters: Parameters?
    var encoding: ParameterEncoding?
    var headers: HTTPHeaders?

    
    init(_ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil){
        self.url = url
        self.method = method
        self.parameters = parameters
        self.encoding = encoding
        self.headers = headers
    }
    init(_ request: DataRequest){
        self.request = request
    }
    public func responseJSON(
        queue: DispatchQueue? = nil,
        options: JSONSerialization.ReadingOptions = .allowFragments,
        completionHandler: @escaping (DataResponse<Any>) -> Void)
    {
        
        if let url = url {
            
            AlamofireInterceptor.shared.launchWithRequest(url, method: method!, parameters: parameters, encoding: encoding!, headers: headers, completionHandler: completionHandler)
            
        }else{
            guard let request = self.request else {
                return
            }
            request.responseJSON(queue:queue, options:options, completionHandler: { response in
                
                InterceptorPreference.setResponse((response.value as! [String: Any])._convertedToJSONString())
                
                
                if InterceptorPreference.responseInterceptIsEnabled() {
                    AlamofireInterceptor.shared.lauchWithResponse(response:response, completionHandler: completionHandler)
                }else{
                    completionHandler(response)
                }
            })
        }
    }
}

//
//  AlamofireInterceptor.swift
//  AlamofireInterceptor
//
//  Created by Nehal Elsawaf on 2/17/19.
//  Copyright © 2019 Yehia Elbehery. All rights reserved.
//

import Alamofire

public class AlamofireInterceptor: NSObject {

    static public let shared: AlamofireInterceptor = {
        return AlamofireInterceptor()
    }()
    public func request(
        _ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil)
        -> InterceptorDataRequest
    {
        if InterceptorPreference.requestInterceptIsEnabled() {
            return InterceptorDataRequest(url,
                method: method,
                parameters: parameters,
                encoding: encoding,
                headers: headers)
        }else{
            
            return requestExecute(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
        }
    }
    func requestExecute(
        _ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil)
        -> InterceptorDataRequest {
        
            do {
                InterceptorPreference.setUrl(try url.asURL().absoluteString)
                if let parameters = parameters {
                    InterceptorPreference.setParams(parameters._convertedToJSONString())
                }
            } catch {
                
            }
            
        return InterceptorDataRequest(Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers))
    }
    
    public func launch(inViewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) {
        guard let parentViewController = inViewController else{
            return
        }
        let bundle = Bundle(for: type(of: self))
        let interceptor = UIStoryboard(name:"InterceptorView", bundle:bundle).instantiateViewController(withIdentifier: "Interceptor") as! InterceptorViewController
        parentViewController.present(interceptor, animated: true)
    }
    func launchWithRequest(
        _ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil,
        completionHandler: @escaping (DataResponse<Any>) -> Void){
        guard let parentViewController = UIApplication.shared.keyWindow?.rootViewController else{
            return
        }
        let bundle = Bundle(for: type(of: self))
        let interceptor = UIStoryboard(name:"InterceptorView", bundle:bundle).instantiateViewController(withIdentifier: "Interceptor") as! InterceptorViewController
        
        interceptor.url = url
        interceptor.method = method
        interceptor.parameters = parameters
        interceptor.encoding = encoding
        interceptor.headers = headers
        interceptor.completionHandler = completionHandler
        
        parentViewController.present(interceptor, animated: true)
    }
    func lauchWithResponse(response: DataResponse<Any>, completionHandler: @escaping (DataResponse<Any>) -> Void){
        guard let parentViewController = UIApplication.shared.keyWindow?.rootViewController else{
            return
        }
        let bundle = Bundle(for: type(of: self))
        let interceptor = UIStoryboard(name:"InterceptorView", bundle:bundle).instantiateViewController(withIdentifier: "Interceptor") as! InterceptorViewController
        
        interceptor.response = response
        interceptor.completionHandler = completionHandler
        
        parentViewController.present(interceptor, animated: true)
    }
}

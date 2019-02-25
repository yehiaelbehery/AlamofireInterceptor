//
//  InterceptorViewController.swift
//  AlamofireInterceptor
//
//  Created by Nehal Elsawaf on 2/17/19.
//  Copyright © 2019 Yehia Elbehery. All rights reserved.
//

import UIKit
import Alamofire

class InterceptorViewController: UIViewController {

    @IBOutlet fileprivate var requestInterceptSwitch: UISwitch!
    @IBOutlet fileprivate var responseInterceptSwitch: UISwitch!
    
    @IBOutlet fileprivate var urlTextView: UITextView!
    
    @IBOutlet fileprivate var paramsStackView: UIStackView!
    @IBOutlet fileprivate var paramsTextView: UITextView!
    
    @IBOutlet fileprivate var paramsButtonsPanelStackView: UIStackView!
    @IBOutlet fileprivate var requestRevertButton: UIButton!
    @IBOutlet fileprivate var requestContinueButton: UIButton!
    
    @IBOutlet fileprivate var responseStackView: UIStackView!
    @IBOutlet fileprivate var responseTextView: UITextView!
    
    @IBOutlet fileprivate var responseButtonsPanelStackView: UIStackView!
    @IBOutlet fileprivate var stubUseButton: UIButton!
    @IBOutlet fileprivate var respponseRevertButton: UIButton!
    @IBOutlet fileprivate var responseContinueButton: UIButton!
    
    fileprivate var originalUrl: String!
    fileprivate var originalParams: String!
    fileprivate var originalResponse: String!
    
    var url: URLConvertible?
    var method: HTTPMethod = .get
    var parameters: Parameters? = nil
    var encoding: ParameterEncoding = URLEncoding.default
    var headers: HTTPHeaders?
    
    var response: DataResponse<Any>?
    var completionHandler: ((DataResponse<Any>) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    func isInterceptedRequest() ->  Bool{
        return (url != nil)
    }
    func isInterceptedResponse() -> Bool{
        return (url == nil && completionHandler != nil)
    }
    func initialize(){
        requestInterceptSwitch.isOn = InterceptorPreference.requestInterceptIsEnabled()
        responseInterceptSwitch.isOn = InterceptorPreference.responseInterceptIsEnabled()
        
        originalUrl = InterceptorPreference.getLastRequestUrl()
        urlTextView.text = originalUrl
        
        originalParams = InterceptorPreference.getLastRequestParams()
        paramsTextView.text = originalParams
        if isInterceptedRequest() {
            paramsButtonsPanelStackView.isHidden = false
        }
        
        if isInterceptedResponse() {
            
            urlTextView.isEditable = false
            paramsTextView.isEditable = false
            responseStackView.isHidden = false
            responseButtonsPanelStackView.isHidden = false
            
            
            originalResponse = InterceptorPreference.getLastRequestResponse()
            responseTextView.text = originalResponse
        }else{
            responseStackView.isHidden = true
        }
        
    }
    
    @IBAction fileprivate func closeButtonTapped(){
        self.dismiss(animated: true)
    }
    @IBAction fileprivate func requestIntercepSwitchValueChanged(_ sender: UISwitch){
        InterceptorPreference.requestInterceptSetTo(sender.isOn)
    }
    @IBAction fileprivate func responseInterceptSwitchValueChaned(_ sender: UISwitch){
        InterceptorPreference.responseInterceptSetTo(sender.isOn)
    }
    
    @IBAction fileprivate func requestRevertButtonTapped(){
        paramsTextView.text = originalParams
    }
    @IBAction fileprivate func requestContinueButtonTapped(){
        AlamofireInterceptor.shared.requestExecute(urlTextView.text, method: method, parameters: paramsTextView.text._convertedToDictionary(), encoding: encoding, headers: headers).responseJSON(completionHandler: { response in
            self.completionHandler?(response)
        })
        self.dismiss(animated: true)
    }
    
    @IBAction fileprivate func stubUseButtonTapped(){
        //
    }
    @IBAction fileprivate func responseRevertButtonTapped(){
        responseTextView.text = originalResponse
    }
    @IBAction fileprivate func responseContinueButtonTapped(){
        guard let response = self.response else {
            return
        }
        let manipulatedString = responseTextView.text!
        
        let manipulatedResponse = DataResponse <Any>(
            request: response.request,
            response: response.response,
            data: response.data,
            result: Result(value: {
                return manipulatedString
            }),
            timeline: response.timeline
        )
        
        InterceptorPreference.setResponse(manipulatedString)
        completionHandler?(manipulatedResponse)
        self.dismiss(animated: true)
    }
}
extension InterceptorViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if (paramsTextView.text != originalParams){
            requestRevertButton.isEnabled = true
        }else{
            requestRevertButton.isEnabled = false
        }
        
        if (responseTextView.text != originalResponse){
            respponseRevertButton.isEnabled = true
        }else{
            respponseRevertButton.isEnabled = false
        }
        return true
    }
}

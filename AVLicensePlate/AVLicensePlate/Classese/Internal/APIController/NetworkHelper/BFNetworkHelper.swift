//
//  BFNetworkHelper.swift
//  Benlly
//
//  Created by haipt on 9/8/15.
//  Copyright (c) 2015 Curations. All rights reserved.
//
import UIKit
enum HTTPMethod {
    case POST
    case POST_FORMDATA
    case GET
    case PUT
    case PUT_FORMDATA
    case DELETE
}

typealias RequestSuccessHandler = (AnyObject?) -> Void
typealias RequestFailHandler = (NSError?) -> Void

class BFNetworkHelper: NSObject {
    private var requestManager : AFHTTPRequestOperationManager!
    private var method : HTTPMethod
    private var parameter : AnyObject?
    private var parameterFormData : [String : AnyObject]?
    private var url : String
    private var successHandle : RequestSuccessHandler!
    private var failHandle : RequestFailHandler!
    var flagAddHeader = true
    
    init(url : String, httpMethod : HTTPMethod, parameter : AnyObject?) {
        self.requestManager = AFHTTPRequestOperationManager()
        self.requestManager.requestSerializer.timeoutInterval = AVApi_Timeout
        self.url = url
        self.method = httpMethod
        self.parameter = parameter
    }
    
    init(url : String, httpMethod : HTTPMethod, paramPost : [String : AnyObject]?) {
        self.requestManager = AFHTTPRequestOperationManager()
        self.requestManager.requestSerializer.timeoutInterval = AVApi_Timeout
        self.url = url
        self.method = httpMethod
        self.parameterFormData = paramPost
    }
    
    func addValueHeader(value: String, forKey key: String)
    {
        self.requestManager.requestSerializer.setValue(value, forHTTPHeaderField: key)
    }
    
    /*Call to start network request */
    func startService(
        success: RequestSuccessHandler,
        failure: RequestFailHandler) -> Void
    {
        if self.successHandle == nil {
            self.successHandle = success
        }
        
        if self.failHandle == nil {
            self.failHandle = failure
        }
        
        if !ReachabilityHelper.sharedInstance.isNetworkConntected() {
            weak var weakSelf = self
            UIAlertView.showWithTitle("", message: "", cancelButtonTitle: "OK", otherButtonTitles: ["Thử Lại"], tapBlock: { (alertView, buttonIndex) -> Void in
                if buttonIndex == 1 {
                    weakSelf?.startService({ (response1) -> Void in
                        weakSelf?.successHandle(response1)
                        }, failure: { (error1) -> Void in
                            weakSelf?.failHandle(error1)
                    })
                }
            })
            return
        }
        
        let responseSerializer : AFJSONResponseSerializer = AFJSONResponseSerializer(readingOptions: NSJSONReadingOptions.AllowFragments)
        requestManager.responseSerializer = responseSerializer
        requestManager.responseSerializer.acceptableContentTypes = nil

        requestManager.securityPolicy.validatesDomainName = false
        requestManager.securityPolicy.allowInvalidCertificates = true
        
        //log here
        AVCommonHelper.Log("---->>>> start post with url \(getUrl(url))")
        AVCommonHelper.Log("---->>>> parameter:  ")
        AVCommonHelper.Log(self.parameter)
        
        switch method {
        case .POST_FORMDATA:
            requestManager.POST(getUrl(url), parameters: parameterFormData, success: { (operation : AFHTTPRequestOperation!,response : AnyObject!) -> Void in
                self.processingSussces(operation, response: response)
                }, failure: { (operation : AFHTTPRequestOperation!, error: NSError!) -> Void in
                    self.processingError(operation, error: error)
            })
            break

        case .POST:
            requestManager.POST(getUrl(url), parameters: parameter, success: { (operation : AFHTTPRequestOperation!,response : AnyObject!) -> Void in
                self.processingSussces(operation, response: response)
                }, failure: { (operation : AFHTTPRequestOperation!, error: NSError!) -> Void in
                    self.processingError(operation, error: error)
            })
            break
            
        case .GET:
            requestManager.GET(getUrl(url), parameters: parameter, success: { (operation : AFHTTPRequestOperation!,response : AnyObject!) -> Void in
                self.processingSussces(operation, response: response)
                }, failure: { (operation : AFHTTPRequestOperation!, error: NSError!) -> Void in
                    self.processingError(operation, error: error)
            })
            break
        case .PUT:
            requestManager.PUT(getUrl(url), parameters: parameter, success: { (operation : AFHTTPRequestOperation!,response : AnyObject!) -> Void in
                self.processingSussces(operation, response: response)
                }, failure: { (operation : AFHTTPRequestOperation!, error: NSError!) -> Void in
                    self.processingError(operation, error: error)
            })
            break
        case .PUT_FORMDATA:
            requestManager.PUT(getUrl(url), parameters: parameterFormData, success: { (operation : AFHTTPRequestOperation!,response : AnyObject!) -> Void in
                self.processingSussces(operation, response: response)
                }, failure: { (operation : AFHTTPRequestOperation!, error: NSError!) -> Void in
                    self.processingError(operation, error: error)
            })
            break
        case .DELETE:
            requestManager.DELETE(getUrl(url), parameters: parameter, success: { (operation : AFHTTPRequestOperation!,response : AnyObject!) -> Void in
                self.processingSussces(operation, response: response)
                }, failure: { (operation : AFHTTPRequestOperation!, error: NSError!) -> Void in
                    self.processingError(operation, error: error)
            })
            break
        }
    }
    
    func processingSussces(operation : AFHTTPRequestOperation!,response : AnyObject?) {
        AVCommonHelper.Log("\(response)")
        self.successHandle(response)
    }
    
    //http status code
    //api status code: {"errors": [{"code":4001, "message":"error message", "invalid_fiedls":{"param1":"error message"}}]}
    func processingError(operation : AFHTTPRequestOperation!, error: NSError?) {
        AVCommonHelper.Log("!!!!!!!!!error header: ")
        AVCommonHelper.Log(error)
        AVCommonHelper.Log("!!!!!!!!!error body: ")
        AVCommonHelper.Log(operation.responseObject)
        let errorCode = 500
        let errorMsg = ""
        let errorInfor =  [String: AnyObject]()
        
        let errorReturn: NSError = NSError(domain: errorMsg, code: errorCode, userInfo: errorInfor)
        self.failHandle(errorReturn)
    }
    
    func getUrl(apiUrl: String)->(String) {
        return apiUrl
    }
    
    
    /*cancel requesting*/
    func cancelRequest() {
        for operation in self.requestManager.operationQueue.operations {
            operation.cancel()
        }
    }
}

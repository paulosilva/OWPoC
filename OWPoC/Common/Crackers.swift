//
//  Crackers.swift
//  OWPoC
//
//  Created by Paulo Silva on 29/07/2018.
//  Copyright © 2018 Paulo Silva. All rights reserved.
//

import Foundation

//  Created by Remi Robert on 18/09/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//
// https://github.com/remirobert/Crackers/blob/master/Crackers/Crackers.swift
//

//import UIKit
//
//enum RequestType: String {
//    case POST = "POST"
//    case GET = "GET"
//    case PUT = "PUT"
//    case DELETE = "DELETE"
//}
//
//extension NSData {
//    func convertToJson() -> String {
//        return NSString(bytes: self.bytes, length: self.length, encoding: String.Encoding.utf8.rawValue)! as String
//    }
//}
//
//class CrackersDelegate :NSObject, NSURLConnectionDataDelegate {
//    var crackersDelegatedidFailWithError: (_ error: NSError) -> ()
//    var crackersDelegateconnectionDidFinishLoading: (_ receivedData: NSData?, _ response: URLResponse?) -> ()
//    var crackersReceiveData: NSMutableData?
//    var crackersResponseRequest: URLResponse?
//
//    func connection(_ connection: NSURLConnection, willCacheResponse cachedResponse: CachedURLResponse) -> CachedURLResponse? {
//        print("cache response")
//        return cachedResponse
//    }
//
//    func connection(_ connection: NSURLConnection, didFailWithError error: Error) {
//        self.crackersDelegatedidFailWithError(error as NSError)
//    }
//
//    func connectionDidFinishLoading(_ connection: NSURLConnection) {
//        self.crackersDelegateconnectionDidFinishLoading(self.crackersReceiveData, self.crackersResponseRequest)
//    }
//
//    func connection(_ connection: NSURLConnection, didReceive response: URLResponse) {
//        self.crackersResponseRequest = response
//    }
//
//    func connection(_ connection: NSURLConnection, didReceive data: Data) {
//        self.crackersReceiveData?.append(data)
//    }
//
//    init(error :@escaping ((_ error:NSError) -> ()),
//         finish:@escaping ((_ data:NSData?, _ response:URLResponse?) -> ())) {
//        self.crackersDelegatedidFailWithError = error
//        self.crackersDelegateconnectionDidFinishLoading = finish
//        self.crackersReceiveData = NSMutableData()
//    }
//
//}
//
//class Crackers {
//    let request :NSMutableURLRequest
//
//    func setHeader(value: String, headerField: String) {
//        self.request.setValue(value, forHTTPHeaderField: headerField)
//    }
//
//    func setAutorizationHeader(username: String, password :String) {
//        let appendedString: String = username + ":" + password
//        let encode: NSData = appendedString.data(using: String.Encoding.utf8)! as NSData
//        let encodeAutorization: String = encode.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
//        // NSData.Base64EncodingOptions.allZeros
//        self.request.setValue("Basic " + encodeAutorization, forHTTPHeaderField: "Authorization")
//    }
//
//    func setParameters(parameters: NSDictionary?) {
//        if (parameters != nil) {
//            var jsonData: NSData? = JSONSerialization.dataWithJSONObject(parameters!, options: JSONSerialization.WritingOptions.ArrayLiteralElement)
//            self.request.httpBody = jsonData! as Data
//        }
//    }
//
//    private func makeRequest(httpMethod: String, completion:(data: NSData?, response: NSURLResponse?, error: NSError?) -> ()) {
//        self.request.HTTPMethod = httpMethod
//
//        var connexion :NSURLConnection = NSURLConnection(request: self.request, delegate: CrackersDelegate(error: { (error) -> () in
//            completion(data: nil, response: nil, error: error)
//        }, finish: { (data, response) -> () in
//            completion(data: data, response: response, error: nil)
//        }))!
//        connexion.start()
//    }
//
//    func sendRequest(type:RequestType, blockCompletion completion: (data: NSData?, response: NSURLResponse?, error: NSError?) -> ()) {
//        self.makeRequest(type.rawValue, completion: completion)
//    }
//
//    private func initRequestParameter() {
//        self.request.timeoutInterval = 60
//        self.request.cachePolicy = NSURLRequestCachePolicy.UseProtocolCachePolicy
//    }
//
//    init() {
//        self.request = NSMutableURLRequest()
//        self.initRequestParameter()
//    }
//
//    init(url: String) {
//        self.request = NSMutableURLRequest(URL: NSURL(string: url)!)
//        self.initRequestParameter()
//    }
//}
//

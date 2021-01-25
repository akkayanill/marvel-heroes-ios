//
//  RestService.swift
//  marvel-heroes-ios
//
//  Created by Josh on 23.01.2021.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import RxSwift
import RxCocoa
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG


var printHTMLResponses: Bool = false


public protocol RestService {
    
    func url() -> URL
    
    func headers() -> [String: String]
    
    func parameters() -> [String: AnyObject]?
    
    func method() -> HTTPMethod
    
    func parameterEncoding() -> ParameterEncoding
    
    func path() -> String
    
    func keyPath() -> String?
    
    func request<T: Mappable>(to: T.Type) -> Observable<T>
    
    func checkOffline()
}



public extension RestService {
    
    func checkOffline() {
        print("checkinfOffline situation")
    }
    
    func request<T: Mappable> (to: T.Type) -> Observable<T> {
        //Create an RxSwift observable, which will be the one to call the request when subscribed to
        return Observable<T>.create { observer in
            
            self._request().validate().responseObject(keyPath: keyPath(), completionHandler: { (response : DataResponse<T>) in
                switch response.result {
                case .success(let value):
                    //Everything is fine, return the value in onNext
                    observer.onNext(value)
                case .failure:
                    //Something went wrong, switch on the status code and return the error
                    if let errorStatusCode = response.response?.statusCode {
                        let error = RestServiceError.getErrorType(errorStatusCode)
                        observer.onError(error)
                    }
                }
            })
            
            //Finally, we return a disposable to stop the request
            return Disposables.create {
            }
        }
    }
    
    private func _request() -> DataRequest {
        let url = self.url()
        let method = self.method()
        let parameters = self.parameters()
        let encoding = self.parameterEncoding()
        let headers = self.headers()
        
        
        return Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON { response in
            
            if printHTMLResponses == true {
                print(">>>> URL: \(url)")
                //                print(">>>> Headers:")
                //                headers.prettyPrint()
                if let parameters = parameters {
                    print(">>>> parameters: \(parameters)")
                }
                print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
            }
            
            //Print
            if let response = response.result.value, response is NSNull == false,
               let jsonData = try? JSONSerialization.data(withJSONObject: response, options: [JSONSerialization.WritingOptions.prettyPrinted]),
               let jsonStr = String(data: jsonData, encoding: String.Encoding.utf8) {
                if printHTMLResponses {
                    print("<< \(jsonStr)")
                }
            }
        }
    }
}

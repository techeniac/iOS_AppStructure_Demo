//
//  NetworkClient.swift
//  CommonBase
//
//  Created by Romil Dhanani on 18/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import Alamofire
import ObjectMapper
import NVActivityIndicatorView

public typealias ResponseData = [String: Any]
public typealias ResponseArray = [Any]
public typealias FailureMessage = String
public typealias ResponseString = String
public typealias FailureCode    = String

struct Certificates {
    static let snapacleanerCert =
        Certificates.certificate(filename: "marketdiamond.com")
    
    private static func certificate(filename: String) -> SecCertificate {
        let filePath = Bundle.main.path(forResource: filename, ofType: "der")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: filePath))
        let certificate = SecCertificateCreateWithData(nil, data as CFData)!
        
        return certificate
    }
}


class NetworkClient {
    
    // MARK: - Constant
    struct Constants {
        
        struct RequestHeaderKey {
            static let contentType                  = "Content-Type"
            static let applicationJSON              = "application/json"
        }
        
        struct HeaderKey {
            
            static let Authorization                = "Authorization"
        }
        
        struct ResponseKey {
            
            static let code                         = "code"
            static let data                         = "data"
            static let message                      = "message"
            static let list                         = "list"
            static let serverLastSync               = "server_last_sync"
        }
        
        //MARK:  ResponseCode
        struct ResponseCode {
            
            static let EmailRequired                     = "EMAIL_IS_REQUIRED"
            static let DobRequired                       = "DOB_IS_REQUIRED"
            static let EmailDobRequired                  = "EMAIL_DOB_IS_REQUIRED"
            static let ok                                = "OK"
            static let kTokenExpiredCode                 = "E_TOKEN_EXPIRED"
            static let kUnAuthorized                     = "E_UNAUTHORIZED"
            static let kListNotFound                     = "E_NOT_FOUND"
            static let kNoInternet                       = "NO_INTERNET"
            static let kBadAccess                        = "E_BAD_REQUEST"
        }
    }
    
    // MARK: - Properties
    
    // A Singleton instance
    static let sharedInstance = NetworkClient()
    
    // A network reachability instance
    let networkReachability = NetworkReachabilityManager()
    
    
    static let evaluators = [
        "tradeapi.market.diamonds":
            PinnedCertificatesTrustEvaluator(certificates: [
                Certificates.snapacleanerCert
            ])
    ]
    
    var session =  Session()
    
    // Initialize
    private init() {
        
        networkReachability?.startListening(onUpdatePerforming: { (status) in
            print(status)
        })
        
        setIndicatorViewDefaults()
        
        session = Session(
//            serverTrustManager: ServerTrustManager(evaluators: NetworkClient.evaluators)
        )
    }
    
    // MARK: - Indicator view
    private func setIndicatorViewDefaults() {
        
        NVActivityIndicatorView.DEFAULT_TYPE = .ballSpinFadeLoader
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor.white
        NVActivityIndicatorView.DEFAULT_BLOCKER_SIZE = CGSize(width: 40, height: 40)
        NVActivityIndicatorView.DEFAULT_BLOCKER_MESSAGE_FONT = UIFont.boldSystemFont(ofSize: 17)
    }
    
    func isNetworkAvailable() -> Bool {
        
        guard (networkReachability?.isReachable)! else {
            return false
        }
        
        return true
    }
    
    /// show indicator before network request
    func showIndicator(_ message:String?, stopAfter: Double) {
        
//        let activityData = ActivityData(message: message)
//        KMActivityindicator.startAnimating()
//
//        if stopAfter > 0 {
//            DispatchQueue.main.asyncAfter(deadline: .now() + stopAfter) {
//                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
//                KMActivityindicator.stopAnimating()
//            }
//        }
        
        KMActivityindicator.startAnimating()
    }
    
    ///Stop Indicator Manually
    func stopIndicator() {
//        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        KMActivityindicator.stopAnimating()
    }
    
    
    // MARK: - Network Request
    
    // Global function to call web service
    func request(_ url: URLConvertible, command: String, method: Alamofire.HTTPMethod = .get, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, success:@escaping ((Any, String)->Void), failure:@escaping ((FailureMessage,FailureCode)->Void)) {
        
        // check network reachability
        guard (networkReachability?.isReachable)! else {
            
            KMActivityindicator.stopAnimating()
            failure("No Internet Connection.", Constants.ResponseCode.kNoInternet)
            return
        }
        
        // create final url
        var finalURLString: String = "\(url)\(command)"
        finalURLString = finalURLString.replaceCurlyBracesTo7B().replaceSpaceTo20()
        let finalURL = NSURL(string : finalURLString)! as URL
        
        print(finalURL)
        print(headers)
        // Network request
        session.request(finalURL, method: method, parameters: parameters, /*encoding: JSONEncoding.default,*/ headers: headers).responseJSON { (response: AFDataResponse<Any>) in
            
//            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            KMActivityindicator.stopAnimating()
            print(response)
            switch response.result {
            case .success(let value):

                let responseObject = value as? [String: Any]
                // get status code
                print(responseObject)
                let statusCode = responseObject?[Constants.ResponseKey.code] as? String ?? ""
                
                // get status message
                let message = responseObject?[Constants.ResponseKey.message] as? String ?? ""
                
                //User LogOut
                if statusCode == Constants.ResponseCode.kTokenExpiredCode {
                    ApplicationData.sharedInstance.clearUserData()
                    ApplicationData.sharedInstance.moveToLogin()
                    failure(message,statusCode)
                    return
                }
                
                //User LogOut
                if statusCode == Constants.ResponseCode.kUnAuthorized {
                    ApplicationData.sharedInstance.clearUserData()
                    ApplicationData.sharedInstance.moveToLogin()
                    return
                }
                
                //Chek Code
//                if statusCode != Constants.ResponseCode.ok {
//                    failure(message,statusCode)
//                    return
//                }
                
                // get data object
                let dataObject = responseObject?[Constants.ResponseKey.data]
                
                // pass data as dictionary if data key contains json object
                if let data = dataObject as? ResponseData {
                    success(data, message)
                    return
                }
                else if let data = dataObject as? ResponseArray {
                    success(data, message)
                    return
                }else if let data = dataObject as? ResponseString {
                    success(data, message)
                    return
                }else{
                    failure(message,statusCode)
                    return
                }
                
                
            case .failure(let error):
                let isServerTrustEvaluationError =
                    error.asAFError?.isServerTrustEvaluationError ?? false
                var message: String
                if isServerTrustEvaluationError {
                    message = "Certificate Pinning Error"
                } else {
                    message = error.localizedDescription
                }
                message = error.localizedDescription
                // check result is success
                failure(message,"")
                return
            }
        }
    }
    
    //Stop response Indicator
    func stopResponseIndicator(command : String) {
        
//        if command != AppConstants.URL.Analytics {
//            //            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
//            //            KMActivityindicator.stopAnimating()
//        }
    }
}

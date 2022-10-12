//
//  UploadManager.swift
//  Bank2Grow
//
//  Created by Vish on 15/12/17.
//  Copyright © 2017 Coruscate. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

class UploadManager:NSObject{
    
    // MARK: - Properties
    
    // A Singleton instance
    static let sharedInstance = UploadManager()
    
    // A network reachability instance
    let networkReachability = NetworkReachabilityManager()
    
    var uploadAlertView = UIAlertController()
    var progressUpload = UIProgressView()
    var progressLabel = UILabel()
    private var uploadRequest: Request?
    
    // Initialize
    private override init() {
        super.init()
        self.uploadAlert()
    }
    
    //MARK: UploadAlert
    func uploadAlert() {
        
        uploadAlertView = UIAlertController(title: LanguageManager.localizedString("KLblUploading"), message: "                                 ", preferredStyle: .alert)
        
        let height:NSLayoutConstraint = NSLayoutConstraint(item: uploadAlertView.view, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 140)
        uploadAlertView.view.addConstraint(height)
        
        progressUpload  = UIProgressView(progressViewStyle: .default)
        progressUpload.setProgress(0, animated: true)
        progressUpload.frame = CGRect(x: 10, y: 55, width: 250, height: 0)
        
        progressLabel.frame = CGRect(x: 0, y: 60, width: 250, height: 20)
        progressLabel.textColor = ColorConstants.TextColor
        progressLabel.font = FontScheme.kRegularFont(size: 14.0)
        progressLabel.textAlignment = .center
        uploadAlertView.view.addSubview(progressLabel)
        
        uploadAlertView.view.addSubview(progressUpload)
        
        uploadAlertView.addAction(UIAlertAction(title: LanguageManager.localizedString("KLblCancelCap"), style: .default, handler: { (alert) in
            self.cancelUpload()
        }))
        
    }
    
    func uploadFile(_ url: URLConvertible, command: String,  image : UIImage? = UIImage(), images : [(String,UIImage)] = [] ,fileURL : URL? = nil, fileURLs : [URL] = [], folderKeyvalue : String? = nil, uploadParamKey : String,  params: Parameters? = nil, headers: HTTPHeaders? = nil,isPregress : Bool? = false, success:@escaping ((Any, String)->Void), failure:@escaping ((FailureMessage)->Void)){
        
        // check network reachability
        guard (networkReachability?.isReachable)! else {
            failure("No Internet Connection.")
            return
        }
        
        // create final url
        let finalURLString: String = "\(url)\(command)"
        let finalURL = NSURL(string : finalURLString)! as URL
        
        // parameters
        //let finalParameters: Parameters = params ?? [:]
        
        // print request url and parameters as JSON String
        print("URL: \(finalURL)")
        print("HEADERS: \(headers as Any)")
        
        if isPregress == true {
            progressUpload.progress = 0
            UIViewController.current().present(self.uploadAlertView, animated: true, completion: nil)
        }
        
        uploadRequest = AF.upload(
            multipartFormData: { multipartFormData in
                if image != nil{
                    if let imageData = image?.jpegData(compressionQuality: 0.8){
                        
                        multipartFormData.append(imageData, withName: uploadParamKey, fileName: "\(UUID().uuidString).jpeg", mimeType: "image/jpeg")
                    }
                }
                
                if images.count != 0{
                    for (uploadParamKey, img) in images{
                        if let imageData = img.jpegData(compressionQuality: 0.8){
                            multipartFormData.append(imageData, withName: uploadParamKey, fileName: "\(UUID().uuidString).jpeg", mimeType: "image/jpeg")
                        }
                    }
                }
                
                if fileURLs.count > 0{
                    for url in fileURLs{
                        
                        multipartFormData.append(url, withName: uploadParamKey, fileName: "\(UUID().uuidString).\(url.absoluteString.fileExtension())", mimeType: "\(self.mimeTypeForPath(path: (url.absoluteString.fileExtension())))")
                    }
                }
                
                if folderKeyvalue != nil{
                    
                    multipartFormData.append((folderKeyvalue?.data(using: .utf8)!)!, withName: "file")
                }
                
                if let parm = params{
                    for (key, value) in parm {
                        multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                    }
                }
                
                
        }, to: finalURL, method: .post , headers: headers).uploadProgress(closure: { (progress) in
            self.progressLabel.text = "Uploaded \(ByteCountFormatter.string(fromByteCount: progress.completedUnitCount, countStyle: .file)) of \(ByteCountFormatter.string(fromByteCount: progress.totalUnitCount, countStyle: .file) ) "
            self.progressUpload.setProgress(Float(progress.fractionCompleted), animated: true)
            
            
        })
            .response { response in
                var responseString : String = ""
                var dictonary:NSDictionary?
                self.uploadAlertView.dismiss(animated: true, completion: nil)
                if !(response.data == nil){
                    responseString = String(data: response.data!, encoding: String.Encoding.utf8)!
                }
                if let data = responseString.data(using: String.Encoding.utf8) {
                    do {
                        
                        dictonary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] as NSDictionary?
                        
                        if let dict = dictonary as? [String:Any]{
                            
                            let msg = dict["message"] as? String
                            
//                            let codeMsg : String = dict["code"] as? Int == 200 ? "OK" : "E_BAD_REQUEST"
//                            print(codeMsg)
                            if let code = dict["code"] as? Int == 200 ? "OK" : "E_BAD_REQUEST", code == NetworkClient.Constants.ResponseCode.ok{
                                
                                return success(dict,msg ?? "")
                                
                            }else{
                                
                                return failure(msg ?? "")
                            }
                            
                        }else{
                            
                            return failure(StringConstants.Common.SomethingWrong)
                        }
                        
                    } catch let error as NSError {
                        return failure(error.localizedDescription ?? "")
                    }
                }
        }
    }
    
    //Cancel Upload
    func cancelUpload() {
        uploadRequest?.cancel()
        uploadRequest = nil
    }
    
    func mimeTypeForPath(path: String) -> String {
        let url = NSURL(fileURLWithPath: path)
        let pathExtension = url.pathExtension
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension! as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream"
    }
}


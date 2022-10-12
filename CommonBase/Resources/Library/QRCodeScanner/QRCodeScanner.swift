//
//  QRCodeScanner.swift
//  eRxPharmacy
//
//  Created by Vish on 24/12/18.
//  Copyright © 2018 Vish. All rights reserved.
//

import UIKit
import AVFoundation

protocol QRCodeScannerDelegate {
    func getScannedQrValue(strValue : String)
}

class QRCodeScanner: UIView {

    @IBOutlet var contentView: UIView!

    var captureSession = AVCaptureSession()
    
    var delegate : QRCodeScannerDelegate?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    
    var isQRCodeScanned = false
    
    private let supportedCodeTypes = [AVMetadataObject.ObjectType.upce,
                                      AVMetadataObject.ObjectType.code39,
                                      AVMetadataObject.ObjectType.code39Mod43,
                                      AVMetadataObject.ObjectType.code93,
                                      AVMetadataObject.ObjectType.code128,
                                      AVMetadataObject.ObjectType.ean8,
                                      AVMetadataObject.ObjectType.ean13,
                                      AVMetadataObject.ObjectType.aztec,
                                      AVMetadataObject.ObjectType.pdf417,
                                      AVMetadataObject.ObjectType.itf14,
                                      AVMetadataObject.ObjectType.dataMatrix,
                                      AVMetadataObject.ObjectType.interleaved2of5,
                                      AVMetadataObject.ObjectType.qr]
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("QRCodeScanner", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func startScanning(){
//
//        captureSession = AVCaptureSession()
//
//        // Get the back-facing camera for capturing videos
//        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)
//        AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
//
//        guard let captureDevice = deviceDiscoverySession.devices.first else {
//
//            self.loadNoDataFoundView(message: StringConstants.Common.kFailedToGetCamera, image: nil, isShowButton: false) {
//
//            }
//            return
//        }
//
//        do {
//            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
//            let input = try AVCaptureDeviceInput(device: captureDevice)
//
//            // Set the input device on the capture session.
//            captureSession.addInput(input)
//
//            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
//            let captureMetadataOutput = AVCaptureMetadataOutput()
//            captureSession.addOutput(captureMetadataOutput)
//
//            // Set delegate and use the default dispatch queue to execute the call back
//            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
//            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
//
//        } catch {
//            // If any error occurs, simply print it out and don't continue any more.
//            print(error)
//            self.removeInputOutput()
//
//            self.loadNoDataFoundView(message: StringConstants.Common.kCameraPermission, image: "", isShowButton: false) {
//
//                self.removeLoadAPIFailedView()
//
//                UIViewController.current().view.showConfirmationPopupWithMultiButton(title: "", message: StringConstants.Common.kOpenSettings, cancelButtonTitle: StringConstants.ButtonTitles.KCancel, confirmButtonTitle: StringConstants.ButtonTitles.KOk, onConfirmClick: {
//
//                    self.startScanning()
//                }, onCancelClick: {
//
//                    Utilities.openURL(UIApplication.openSettingsURLString)
//                    self.startScanning()
//                })
//            }
//            return
//        }
//
//        // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
//        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
//        videoPreviewLayer?.frame = self.layer.bounds
//        self.layer.addSublayer(videoPreviewLayer!)
//
//        // Start video capture.
//        captureSession.startRunning()
//
//        // Initialize QR Code Frame to highlight the QR code
//        qrCodeFrameView = UIView()
//
//        if let qrCodeFrameView = qrCodeFrameView {
//            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
//            qrCodeFrameView.layer.borderWidth = 2
//            self.addSubview(qrCodeFrameView)
//            self.bringSubviewToFront(qrCodeFrameView)
//        }
    }
}


extension QRCodeScanner: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is not nil and it contains at least one object.
//        if metadataObjects.count == 0 {
//            qrCodeFrameView?.frame = CGRect.zero
//            return
//        }
//
//        // Get the metadata object.
//        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
//
//        if supportedCodeTypes.contains(metadataObj.type) {
//            // If the found metadata is equal to the QR code metadata (or barcode) then update the status label's text and set the bounds
//            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
//            qrCodeFrameView?.frame = barCodeObject?.bounds ?? CGRect.zero
//
//            if metadataObj.stringValue != nil && isQRCodeScanned == false{
//
//                isQRCodeScanned = true
//                self.delegate?.getScannedQrValue(strValue: metadataObj.stringValue!.fileName())
//
//
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                   self.removeInputOutput()
//                }
//                return
//            }
//        }
    }
    
    func removeInputOutput(){
        self.subviews.forEach({ $0.removeFromSuperview() })
        if let inputs = self.captureSession.inputs as? [AVCaptureDeviceInput] {
            for input in inputs {
                self.captureSession.removeInput(input)
                
            }
        }
        
        if let outputs = self.captureSession.outputs as? [AVCaptureMetadataOutput] {
            for output in outputs {
                self.captureSession.removeOutput(output)
            }
        }
        
        self.qrCodeFrameView?.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
    }
}

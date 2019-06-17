//
//  QRScannerViewController.swift
//  Businect
//
//  Created by Edriss Mosafer on 17.06.19.
//  Copyright © 2019 Scrum-Made. All rights reserved.
//

import UIKit
import AVFoundation
import SceneKit
import ARKit

class QRScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, ARSCNViewDelegate{

    //Videoanzeige der Kamera
    var video = AVCaptureVideoPreviewLayer()
    
    @IBOutlet weak var backview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Creating session
        let session = AVCaptureSession()
        
        //Define capture device
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)!
        
        //add the capture device to our session
        do{
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
          
        }
        catch{
            print("ERROR")
        }
        
        let output = AVCaptureMetadataOutput()
        //add the session
        session.addOutput(output)
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        video = AVCaptureVideoPreviewLayer(session: session)
        //set frame
        video.frame = backview.layer.bounds
        backview.layer.addSublayer(video)
        //session starten
        session.startRunning()
    }
    
    //Falls ein QR Code erkannt wurde, wird eine Benachrichtigung mit dessen Inhalt ausgegeben als eine Benachrichtigung.
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects != nil && metadataObjects.count != 0{
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject{
                if object.type == AVMetadataObject.ObjectType.qr{
                    print("QR gescannt")
                    let alert = UIAlertController(title: "QR Code", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    alert.addAction(UIAlertAction(title: "Kopieren", style: .default, handler: { (nil) in UIPasteboard.general.string = object.stringValue}))
                    present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}

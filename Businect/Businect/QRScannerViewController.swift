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

class QRScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate{

    //Videoanzeige der Kamera
    var video = AVCaptureVideoPreviewLayer()
    
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
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        //session starten
        session.startRunning()
    }
    
    //Falls ein QR Code erkannt wurde, wird eine Benachrichtigung mit dessen Inhalt ausgegeben als eine Benachrichtigung.
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects != nil && metadataObjects.count != 0{
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject{
                if object.type == AVMetadataObject.ObjectType.qr{
                    print("Wechsel")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "your_VC_ID") as! ARViewController
                    self.present(vc, animated: true, completion: nil)
                    let alert = UIAlertController(title: "QR Code", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    alert.addAction(UIAlertAction(title: "Kopieren", style: .default, handler: { (nil) in UIPasteboard.general.string = object.stringValue}))
                    print("kein Wechsel")
                    //let vc = ARViewController()
                    //self.present(vc, animated: true, completion: nil)
                    present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}

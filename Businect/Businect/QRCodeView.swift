//
//  QRCodeView.swift
//  Businect
//
// Created by Muqarab and Max
// Copyright © 2019 Scrum-Made. All rights reserved.

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class QRCodeView: UIViewController {
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var Button2: UIButton!

    // Wenn die Seite geladen wird, wird automatisch ein QR-Code für den Nutzer aus seiner Firebase URL erstellt. Zudem wird ein Screenshot des Barcode direkt im Firebase Storage gespeichert.
    // Created by Muqarab and Max
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataURL = (Auth.auth().currentUser?.displayName)!
        let data = dataURL.data(using: .ascii, allowLossyConversion:true)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey:"InputMessage")
        let ciImage = filter?.outputImage
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let transformImage = ciImage?.transformed(by: transform)
        let image = UIImage(ciImage: transformImage!)
        myImageView.image = image
        
        let top: CGFloat = 150
        let bottom: CGFloat = 300
        let size = CGSize(width: view.frame.size.width, height: view.frame.size.height - top - bottom)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: -top)
        view.layer.render(in: context)
        let snapshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let image1 = snapshot else { return }
        guard let imageData2 = image1.pngData() else { return }
        var fotoName : String = ""
        fotoName = Auth.auth().currentUser?.email ?? ""
        let dateiFormat = "QRCode.png"
        let uploadImageRef = imageReference.child(fotoName+dateiFormat)
        let uploadTask = uploadImageRef.putData(imageData2, metadata: nil) { (metadata, error) in
            print("UPLOAD TASK FINISHED")
            print(metadata ?? "NO METADATA")
            print(error ?? "NO ERROR")
        }
        uploadTask.observe(.progress){ (snapshot) in
            print(snapshot.progress ?? "NO MORE PROGRESS")
        }
        uploadTask.resume()
    }
    
    
    var imageReference: StorageReference {
        return Storage.storage().reference().child("images")
    }
    
    @IBAction func buttonShare(_sender: Any){
        shareMethod()
    }
    
    // Funktion um einen Screenshot des QR-Codes zu machen und zu teilen
    // Created by Muqarab
    func shareMethod(){
        Button2.isHidden = true
        let top: CGFloat = 200
        let bottom: CGFloat = 300
        let size = CGSize(width: view.frame.size.width, height: view.frame.size.height - top - bottom)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: -top)
        view.layer.render(in: context)
        let snapshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let activityVC = UIActivityViewController(activityItems: [snapshot!], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
        Button2.isHidden=false
    }
}

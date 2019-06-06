//
//  QRCodeView.swift
//  Businect
//
//  Created by Muqarab Afzal on 03.06.19.
//  Copyright © 2019 Scrum-Made. All rights reserved.
//
import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class QRCodeView: UIViewController {
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var Businect: UIImageView!
    
    
    @IBOutlet weak var Button2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //       Daten die im QRCode eingebettet sein sollen
        let dataa = "https://scrummadedb.firebaseio.com/Benutzer/" + (Auth.auth().currentUser?.displayName)!
        //
        let data = dataa.data(using: .ascii, allowLossyConversion:true)
        //        Filter erstellem
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey:"InputMessage")
        //        müssen mit ciImage arbeiten
        let ciImage = filter?.outputImage
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let transformImage = ciImage?.transformed(by: transform)
        
        let image = UIImage(ciImage: transformImage!)
        myImageView.image = image
        
        
        let top: CGFloat = 200
        let bottom: CGFloat = 300
        
        // TDie Größe des verkleinerten Screenshots.
        let size = CGSize(width: view.frame.size.width, height: view.frame.size.height - top - bottom)
        
        // Kontext Starten
        UIGraphicsBeginImageContext(size)
        
        
        let context = UIGraphicsGetCurrentContext()!
        
        // Transformiere den Kontext
        // Was vorher bei (0,0) gezeichnet wurde wird jetzt bei (0,-top) gezeichnet
        // Die top Pixels werden abgeschnitten
        // Die bottom Pixels werden auch weggeschnitten
        
        context.translateBy(x: 0, y: -top)
        
        // Damit wird ein Screenshot gemacht
        view.layer.render(in: context)
        let snapshot = UIGraphicsGetImageFromCurrentImageContext()
        
        // Kontext beenden Methode ist notwendig
        UIGraphicsEndImageContext()
        
        // Save to photos
        //        UIImageWriteToSavedPhotosAlbum(snapshot!, nil, nil, nil)
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
    //Methode um nachher einen Screenshot des QR-Codes zu speichern
    func shareMethod(){
        let top: CGFloat = 200
        let bottom: CGFloat = 300
        
        // TDie Größe des verkleinerten Screenshots.
        let size = CGSize(width: view.frame.size.width, height: view.frame.size.height - top - bottom)
        
        // Kontext Starten
        UIGraphicsBeginImageContext(size)
        
        
        let context = UIGraphicsGetCurrentContext()!
        
        // Transformiere den Kontext
        // Was vorher bei (0,0) gezeichnet wurde wird jetzt bei (0,-top) gezeichnet
        // Die top Pixels werden abgeschnitten
        // Die bottom Pixels werden auch weggeschnitten
        
        context.translateBy(x: 0, y: -top)
        
        // Damit wird ein Screenshot gemacht
        view.layer.render(in: context)
        let snapshot = UIGraphicsGetImageFromCurrentImageContext()
        
        // Kontext beenden Methode ist notwendig
        UIGraphicsEndImageContext()
        //        der Screenshot kann durch die Methoden geshared werden
        let activityVC = UIActivityViewController(activityItems: [snapshot!], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
        
    }
    
    
    
}

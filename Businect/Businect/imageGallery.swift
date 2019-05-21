//
//  imageGallery.swift
//  Businect
//
//  Created by Muqarab Afzal on 03.05.19.
//  Copyright © 2019 Scrum-Made. All rights reserved.
//


import UIKit
import Firebase
import FirebaseStorage

class imageGallery: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imgImage: UIImageView!
    var imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        FotoAuswählenEnablen.isEnabled = true
        RegistrierungAbschließenEnablen.isEnabled = false
    }
    
    var imageReference: StorageReference {
        return Storage.storage().reference().child("images")
    }
    
    
    @IBOutlet weak var FotoAuswählenEnablen: UIButton!
    
    @IBOutlet weak var RegistrierungAbschließenEnablen: UIButton!
    
    
    @IBAction func btnGalleryTapped(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
        FotoAuswählenEnablen.isEnabled = false
        RegistrierungAbschließenEnablen.isEnabled = true
    }

    @IBAction func uplouddb(_ sender: Any) {
            guard let image = imgImage.image else { return }
            guard let imageData2 = image.pngData() else { return }
            var fotoName : String = ""
            fotoName = Auth.auth().currentUser?.email ?? ""
            let dateiFormat = ".png"
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        
        var selectedImage: UIImage?
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
            self.imgImage.image = selectedImage!
            picker.dismiss(animated: true, completion: nil)
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
            self.imgImage.image = selectedImage!
            picker.dismiss(animated: true, completion: nil)
        }
    }
}

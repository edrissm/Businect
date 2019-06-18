//
//  imageGallery.swift
//  Businect
//  Created by Nina, Muqarab and Edriss
//  Copyright © 2019 Scrum-Made. All rights reserved.


import UIKit
import Firebase
import FirebaseStorage


// Klasse, um ein Profilfoto aus der Gallerie des Smart-Phones auszuwählen und dieses dann zu in das Storage der Firebase- Datenbank hochzuladen.
class ProfilephotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imgImage: UIImageView!   //Wo ausgewählte Profilfoto angezeigt wird
    
    var imagePicker = UIImagePickerController()
    @IBOutlet weak var pickImageEnable: UIButton!
    @IBOutlet weak var finishRegistrationEnablen: UIButton!
    
    // Man kann erst die Seite verlassen, nachdem man ein Profilfoto aus der Galerie ausgewählt hat.
    // Created by Nina
    override func viewDidLoad() {
        super.viewDidLoad()
        pickImageEnable.isEnabled = true
        finishRegistrationEnablen.isEnabled = false
    }
    
    var imageReference: StorageReference {
        return Storage.storage().reference().child("images")
    }
    
    // Wenn ein Foto in der Galerie ausgewählt wird, wird dieses in den UIIMageView eingefügt und dem Benutzer wird es ermöglicht auf "Weiter" zu klicken
    // Created by Muqarab
    @IBAction func galleryTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
        pickImageEnable.isEnabled = false
        finishRegistrationEnablen.isEnabled = true
    }
    
    // Das Foto, welches sich im UIImageView befindet, wird auf in das Firebase-Storage geladen.
    // Created by Nina and Edriss
    @IBAction func uploadImgToFirebase(_ sender: Any) {
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
    
    // Durch klicken auf den Button "Profilfoto asuwählen" wir die Galerie des Bentuzers geöfnet.
    // Created by Muqarab
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

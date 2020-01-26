//
//  TravelAddingViewController.swift
//  TravelPlanner
//
//  Created by Thanakorn Amnajsatit on 24/1/2563 BE.
//  Copyright © 2563 GAS. All rights reserved.
//

import UIKit
import Firebase

class TravelAddingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - Properties
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addImgButton: UIButton!
    @IBOutlet weak var descriptionTV: UITextView!
    @IBOutlet weak var airlineTF: UITextField!
    @IBOutlet weak var hotelTF: UITextField!
    @IBOutlet weak var pointOfInterestTF: UITextField!
    @IBOutlet weak var budgetStartTF: UITextField!
    @IBOutlet weak var budgetEndTF: UITextField!
    @IBOutlet weak var sinceDateTF: UITextField!
    @IBOutlet weak var sinceMonthTF: UITextField!
    @IBOutlet weak var sinceYearTF: UITextField!
    @IBOutlet weak var untilDateTF: UITextField!
    @IBOutlet weak var untilMonthTF: UITextField!
    @IBOutlet weak var untilYearTF: UITextField!
    
    var imagePicker = UIImagePickerController()
    var delegate: HomeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        imagePicker.delegate = self
    }
    
    func setupViews() {
        self.descriptionTV.layer.borderWidth = 0.5
        self.descriptionTV.layer.borderColor = UIColor.lightGray.cgColor
        self.descriptionTV.layer.cornerRadius = 5
    }
    
    @IBAction func addImageBtnTapped(_ sender: Any) {
        self.imagePicker.allowsEditing = false
        self.imagePicker.sourceType = .photoLibrary
        
        present(self.imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addBtnTapped(_ sender: Any) {
        let randomImgId = "\(UUID.init().uuidString).jpg"
        let data: [String: Any] = [
            "title": self.titleTF.text ?? "",
            "description": self.descriptionTV.text ?? "",
            "airline": self.airlineTF.text ?? "",
            "hotel": self.hotelTF.text ?? "",
            "point_of_interest": self.pointOfInterestTF.text ?? "",
            "budget_start": self.budgetStartTF.text ?? "",
            "budget_end": self.budgetEndTF.text ?? "",
            "schedule_since": "\(self.sinceDateTF.text ?? "")/\(self.sinceMonthTF.text ?? "")/\(self.sinceYearTF.text ?? "")",
            "schedule_until": "\(self.untilDateTF.text ?? "")/\(self.untilMonthTF.text ?? "")/\(self.untilYearTF.text ?? "")",
            "photo_path": randomImgId,
        ]
        
        guard let imageData = self.imageView.image?.jpegData(compressionQuality: 0.75) else { return }
        let uploadMetaData = StorageMetadata.init()
        uploadMetaData.contentType = "image/jpeg"
        
        // Upload image to storage.
        FirebaseManager.storage.reference(withPath: randomImgId).putData(imageData, metadata: uploadMetaData) { (downloadMetaData, error) in
            if error != nil {
                fatalError("Cannot upload image to storage.")
            }
        }
        
        // Upload trip data to Firestore.
        FirebaseManager.root.collection(FirestoreKeys.travel_data).addDocument(data: data) { (error) in
            if error != nil {
                fatalError("Cannot add trip data to Firestore.")
            }
        }
        
        self.delegate?.goToHomeVC(identifier: "MainIdentifier")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imageView.contentMode = .scaleAspectFit
            self.imageView.image = pickedImage
        }
        self.addImgButton.isHidden = true
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

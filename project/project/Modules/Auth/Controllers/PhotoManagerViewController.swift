//
//  PhotoManagerViewController.swift
//  project
//
//  Created by Mohammad Bitar on 9/30/20.
//

import UIKit
import Firebase

class PhotoManagerViewController: MasterViewController {

    // MARK: - IBOUTLETS
    
    @IBOutlet weak var photoView: CustomView! {
        didSet {
            photoView.addBorder(width: 1, corner: photoView.frame.height / 2, color: UIColor.clear.cgColor)
        }
    }
    @IBOutlet weak var photo: UIImageView!
    
    // MARK: - ARIABLES
    
    var viewModel: AuthViewModel?
    var pickerImage: UIImage? {
        didSet {
            guard let image = pickerImage else { return }
            photo.image = image
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - FUNCTIONS
    
    func setupImagePicker(sourceType: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.sourceType = sourceType
        picker.delegate = self
        
        self.present(picker, animated: true, completion: nil)
    }
    
    // MARK: - IBACTIONS
    
    @IBAction func openImagegalleryButtonTapped(_ sender: UIButton) {
        setupImagePicker(sourceType: .photoLibrary)
    }
    
    @IBAction func takePhotoButtonTapped(_ sender: UIButton) {
        setupImagePicker(sourceType: .camera)
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        popViewController()
    }
    
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        viewModel?.createProfile(completion: { [weak self] (success, error) in
            guard let strongSelf = self else { return }
            if success {
                let vc = strongSelf.storyboard?.instantiateViewController(withIdentifier: GlobalVariables.Controllers.FinishViewController.rawValue) as! FinishViewController
                strongSelf.navigationController?.pushViewController(vc, animated: true)
            } else {
                Alert.showError(on: strongSelf, with: error!)
            }
        })
    }
    
}

extension PhotoManagerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.pickerImage = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.pickerImage = originalImage
        } else {
            Alert.showError(on: self, with: GlobalVariables.Messages.UnableToGetPhoto.rawValue)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

//
//  UploadPhotoViewController.swift
//  project
//
//  Created by Mohammad Bitar on 9/30/20.
//

import UIKit

class UploadPhotoViewController: MasterViewController {

    // MARK: - IBOUTLETS
    
    @IBOutlet weak var photoView: CustomView! {
        didSet {
            photoView.addBorder(width: 1, corner: photoView.frame.height / 2, color: UIColor.clear.cgColor)
        }
    }
    @IBOutlet weak var photoButton: UIButton!
    
    // MARK: - VARIABLES
    
    var viewModel: AuthViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBACTIONS
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        popViewController()
    }
    
    @IBAction func openPhotoManagerButtonTapped(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: GlobalVariables.Controllers.PhotoManagerViewController.rawValue) as! PhotoManagerViewController
        vc.viewModel = viewModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: GlobalVariables.Controllers.FinishViewController.rawValue) as! FinishViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

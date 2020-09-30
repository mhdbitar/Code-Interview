//
//  GenderViewController.swift
//  project
//
//  Created by Mohammad Bitar on 9/30/20.
//

import UIKit

class GenderViewController: MasterViewController {

    // MARK: - IBOUTLETS

    @IBOutlet weak var femaleView: CustomView! {
        didSet {
            femaleView.addBorder(width: 1.0, corner: femaleView.frame.size.width / 2, color: UIColor.clear.cgColor)
        }
    }
    @IBOutlet weak var maleView: CustomView! {
        didSet {
            maleView.addBorder(width: 1.0, corner: maleView.frame.size.width / 2, color: UIColor.clear.cgColor)
        }
    }
    
    // MARK: - VARIABLES
    
    var viewModel: AuthViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBACTIONS
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        popViewController()
    }
    
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: GlobalVariables.Controllers.UploadPhotoViewController.rawValue) as! UploadPhotoViewController
        vc.viewModel = viewModel
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func selectGenderButtonTapped(_ sender: UIButton) {
        var gender = ""
        if sender.tag == 1 { // Male
            gender = GlobalVariables.Genders.Male.rawValue
            maleView.borderColor = UIColor(red: 2/255, green: 27/255, blue: 52/255, alpha: 1.0)
            femaleView.borderColor = .clear
        } else if sender.tag == 2 { // Female
            gender = GlobalVariables.Genders.Female.rawValue
            maleView.borderColor = .clear
            femaleView.borderColor = UIColor(red: 2/255, green: 27/255, blue: 52/255, alpha: 1.0)
        }
        
        viewModel?.updateGender(gender: gender)
    }
}

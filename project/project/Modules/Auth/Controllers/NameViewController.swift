//
//  NameViewController.swift
//  project
//
//  Created by Mohammad Bitar on 9/30/20.
//

import UIKit

class NameViewController: MasterViewController {

    // MARK: - IBOUTLETS
    @IBOutlet weak var nameTextField: UITextField!
    
    // MARK: - VARIABLES
    
    var viewModel: AuthViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
    }
    
    // MARK: - FUNCTIONS
    
    func validate() -> Bool {
        hideKeyboard()
        let name = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if name == "" {
            return false
        }
        
        viewModel?.updateName(name: name!)
        return true
    }
    
    func nextStep() {
        if validate() {
            let vc = storyboard?.instantiateViewController(withIdentifier: GlobalVariables.Controllers.GenderViewController.rawValue) as! GenderViewController
            vc.viewModel = viewModel
            navigationController?.pushViewController(vc, animated: true)
        } else {
            Alert.showError(on: self, with: GlobalVariables.Messages.FieldReuiqred.rawValue)
        }
        
    }
    
    // MARK: - IBACTIONS
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        popViewController()
    }
    
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        nextStep()
    }
    
}

extension NameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        nextStep()
        return true
    }
}

//
//  VerifyPhoneNumberViewController.swift
//  project
//
//  Created by Mohammad Bitar on 9/26/20.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class VerifyPhoneNumberViewController: MasterViewController {

    // MARK: - IBOUTLETS
    
    @IBOutlet weak var codeTextField: OneTimeCodeTextField!
    
    // MARK: - VARIABLES
    
    var viewModel: AuthViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        codeTextField.configure(with: 6)
        codeTextField.didEnterLastDigits = { [weak self] _ in
            self?.validateCode()
        }
    }
    
    // MARK: - FUNCTIONS
    
    func validateCode() {
        guard let otpCode = codeTextField.text else { return }
        
        authManager.verifiyCode(verificationId: UserDefaults.getValue(key: GlobalVariables.Parameters.VerificationId.rawValue), code: otpCode) { [weak self] (success, user, error) in
            guard let strongSelf = self else { return }
            if error == nil {
                Alert.showSuccess(on: strongSelf, with: GlobalVariables.Messages.PhoneVerified.rawValue)
            } else {
                Alert.showError(on: strongSelf, with: GlobalVariables.Messages.LoginFailed.rawValue)
            }
        }
    }
    
    // MARK: - IBACTIONS
    
    @IBAction func validateCodeButtonTapped(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: GlobalVariables.Controllers.NameViewController.rawValue) as! NameViewController
        vc.viewModel = viewModel
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func resendVerificationCodeButtonTapped(_ sender: UIButton) {
        viewModel?.getVerificationCode(complete: { [weak self] (success, error) in
            guard let strongSelf = self else { return }
            if !success {
                Alert.showError(on: strongSelf, with: error ?? GlobalVariables.Messages.GlobalError.rawValue)
            }
        })
    }
    
}

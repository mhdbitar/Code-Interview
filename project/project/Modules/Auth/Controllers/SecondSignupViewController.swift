//
//  SecondSignupViewController.swift
//  project
//
//  Created by Mohammad Bitar on 9/26/20.
//

import UIKit

protocol SignupDelegate: class {
    func getCountryCode(code: String)
    func getPhoneNumber(phone: String)
}

class SecondSignupViewController: MasterViewController {

    // MARK: - IBOUTLETS
    
    @IBOutlet weak var countryCodeButton: UIButton!
    @IBOutlet weak var phoneNumberButton: UIButton!
    
    // MARK: - VARIABLES
    
    var viewModel: AuthViewModel?
    
    var selectedCode: String = "" {
        willSet {
            countryCodeButton.setTitle(newValue, for: .normal)
            viewModel?.updateCountryCode(code: newValue)
        }
    }
    
    var selectedPhoneNumber: String = "" {
        willSet {
            phoneNumberButton.setTitle(newValue, for: .normal)
            viewModel?.updatePhoneNumber(phone: newValue)
        }
    }
    
    // MARK: - IBACTIONS
    
    @IBAction func showCountryCodeButtonTapped(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: GlobalVariables.Controllers.CountryCodeViewController.rawValue) as? CountryCodeViewController else {
            return
        }
        slideInTransitionDelegate.direction = .bottom
        vc.transitioningDelegate = slideInTransitionDelegate
        vc.modalPresentationStyle = .custom
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    @IBAction func showPhoneNumberButtonTapped(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: GlobalVariables.Controllers.PhoneNumberViewController.rawValue) as? PhoneNumberViewController else {
            return
        }
        slideInTransitionDelegate.direction = .bottom
        vc.transitioningDelegate = slideInTransitionDelegate
        vc.modalPresentationStyle = .custom
        vc.delegate = self
        vc.code = selectedCode
        self.present(vc, animated: true)
    }
    
    @IBAction func sendVerificationButtonTapped(_ sender: UIButton) {
        if !selectedCode.isEmpty && !selectedPhoneNumber.isEmpty {
            viewModel?.getVerificationCode { [weak self] (success, error) in
                guard let strongSelf = self else { return }
                if success {
                    let vc = strongSelf.storyboard?.instantiateViewController(withIdentifier: GlobalVariables.Controllers.VerifyPhoneNumberViewController.rawValue) as! VerifyPhoneNumberViewController
                    vc.viewModel = strongSelf.viewModel
                    strongSelf.navigationController?.pushViewController(vc, animated: true)
                } else {
                    Alert.showError(on: strongSelf, with: error ?? GlobalVariables.Messages.GlobalError.rawValue)
                }
            }
        }
    }    
}

extension SecondSignupViewController: SignupDelegate {
    
    func getCountryCode(code: String) {
        selectedCode = code
    }
    
    func getPhoneNumber(phone: String) {
        selectedPhoneNumber = phone
    }
}

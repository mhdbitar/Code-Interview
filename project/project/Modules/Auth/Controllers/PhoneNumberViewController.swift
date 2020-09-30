//
//  PhoneNumberViewController.swift
//  project
//
//  Created by Mohammad Bitar on 9/26/20.
//

import UIKit
import SwiftPhoneNumberFormatter

class PhoneNumberViewController: MasterViewController {

    // MARK: - IBOUTLETS
    
    @IBOutlet weak var countryCodeButton: UIButton!
    @IBOutlet weak var phoneNumberTextField: PhoneFormattedTextField! {
        didSet {
            phoneNumberTextField.config.defaultConfiguration = PhoneFormat(defaultPhoneFormat: "(###) ###-##-##")
            phoneNumberTextField.becomeFirstResponder()
        }
    }
    
    // MARK: - VARIABLES
    
    var selectedPhoneNumber: String = ""
    var code: String = ""
    weak var delegate: SignupDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryCodeButton.setTitle(code, for: .normal)
        phoneNumberTextField.delegate = self
        
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: - FUNCTIONS
    
    func validate() -> Bool {
        hideKeyboard()
        let phone = phoneNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if phone == "" {
            return false
        }
        
        return true
    }
    
    @objc func submitForm() {
        if validate() {
            dismiss(animated: true) {
                if self.delegate != nil {
                    if let phoneNumber = self.phoneNumberTextField.text {
                        self.delegate?.getPhoneNumber(phone: phoneNumber)
                    }
                }
            }
        } else {
            Alert.showError(on: self, with: GlobalVariables.Messages.GlobalError.rawValue)
        }
    }

    
}

extension PhoneNumberViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        submitForm()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let bar = UIToolbar()
        let close = UIBarButtonItem(title: GlobalVariables.Buttons.Close.rawValue, style: .plain, target: self, action: #selector(hideKeyboard))
        let submit = UIBarButtonItem(title: GlobalVariables.Buttons.Done.rawValue, style: .done, target: self, action: #selector(submitForm))
        
        close.tintColor = .red
        bar.items = [close, submit]
        bar.sizeToFit()
        textField.inputAccessoryView = bar
        return true
    }
}

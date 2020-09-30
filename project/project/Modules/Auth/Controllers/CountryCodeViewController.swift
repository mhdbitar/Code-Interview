//
//  CountryCodeViewController.swift
//  project
//
//  Created by Mohammad Bitar on 9/26/20.
//

import UIKit
import CountryPicker

class CountryCodeViewController: MasterViewController, CountryPickerDelegate {

    // MARK: - IBOUTLETS
    
    @IBOutlet weak var pickerView: CountryPicker!
    
    // MARK: - VARIABLES
    
    var selectedCode: String = ""
    weak var delegate: SignupDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //init Picker
        let theme = CountryViewTheme(countryCodeTextColor: .black, countryNameTextColor: .black, rowBackgroundColor: .white, showFlagsBorder: true)
        pickerView.theme = theme
        pickerView.countryPickerDelegate = self
        pickerView.showPhoneNumbers = true
        pickerView.setCountry("US")
        

    }
    
    // a picker item was selected
    func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        //pick up anythink
        selectedCode = phoneCode
    }
    
    // MARK: - IBACTIONS
    
    @IBAction func closeModalButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        dismiss(animated: true) {
            if self.delegate != nil {
                self.delegate?.getCountryCode(code: self.selectedCode)
            }
        }
    }
}


//
//  AuthViewModel.swift
//  project
//
//  Created by Mohammad Bitar on 9/30/20.
//

import UIKit
import Firebase

class AuthViewModel {
    
    var id: String = ""
    var name: String = ""
    var gender: String = ""
    var countryCode: String = ""
    var phoneNumber: String = ""
    var url: String = ""
    var photo: UIImage?
    
    var authManager: FirebaseAuthManager?
    
    init(authManager: FirebaseAuthManager) {
        self.authManager = authManager
    }
    
    func updateName(name: String) {
        self.name = name
    }
    
    func updateCountryCode(code: String) {
        self.countryCode = code
    }
    
    func updatePhoneNumber(phone: String) {
        self.phoneNumber = phone
    }
    
    func updateGender(gender: String) {
        self.gender = gender
    }
    
    func updatePhoto(image: UIImage?) {
        self.photo = image
    }

    func getPhoneNumber() -> String {
        return countryCode + phoneNumber
    }
    
    func getVerificationCode(complete: @escaping ( _ success: Bool, _ error: String?)->()) {
        let phone = countryCode + phoneNumber
        authManager?.loginByPhoneNumber(phoneNumber: phone) { (success, verificationId, error) in
            if error == nil {
                UserDefaults.setValue(key: GlobalVariables.Parameters.VerificationId.rawValue, value: verificationId!)
                complete(true, nil)
            } else {
                complete(false, GlobalVariables.Messages.SecretVerification.rawValue)
            }
        }
    }
    
    func createProfile(completion: @escaping (_ success: Bool, _ error: String?) -> ()) {
        let user = ["name": name, "gender": gender, "phoneNumber": getPhoneNumber()]
        let ref = Database.database().reference()
        ref.child(GlobalVariables.Database.Users.rawValue).child(!id.isEmpty ? id : name).setValue(user, withCompletionBlock: { (error, _) in
            if error != nil {
                completion(false, error?.localizedDescription)
            } else {
                UserDefaults.setValue(key: GlobalVariables.Parameters.IsLoggedIn.rawValue, value: "1")
                completion(true, nil)
            }
        })
    }
}

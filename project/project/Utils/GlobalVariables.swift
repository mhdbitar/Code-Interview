//
//  GlobalVariables.swift
//  project
//
//  Created by Mohammad Bitar on 9/25/20.
//

import Foundation

class GlobalVariables: NSObject {
    
    // Database
    enum Database: String {
        case Users
    }
    
    // Storyboards
    enum Storyboards: String {
        case Main
        case Auth
    }
    
    // Controllers
    enum Controllers: String {
        // General
        case SplashViewController
        
        // Home
        case HomeViewController
        
        // Authentication
        case FirstSignupViewController
        case SecondSignupViewController
        case CountryCodeViewController
        case PhoneNumberViewController
        case VerifyPhoneNumberViewController
        case NameViewController
        case GenderViewController
        case UploadPhotoViewController
        case PhotoManagerViewController
        case FinishViewController
        case LoginViewController
        
    }
    
    // ViewCells
    enum ViewCells: String {
        case WordTableViewCell
    }
    
    // Input and UserDefaults Keys
    enum Parameters: String {
        case IsLoggedIn = "isLoggedIn"
        case VerificationId = "verificationId"
    }
    
    enum Messages: String {
        case GlobalError = "Something went wrong, please try again later."
        case DeserializeError = "Failed to deserialize."
        case Verified = "Verification successful!"
        case LoginFailed = "Failed to Sign in"
        case FieldReuiqred = "Field is Required."
        case NoData = "There is no word that matches the entered keyword."
        case SecretVerification = "Unable to get Secret Verification Code."
        case PhoneVerified = "The phone number verification has been completed, please tap on the next button to continue."
        case UnableToGetPhoto = "Unable to get the Photo."
        case UploadError = "Failed to upload the image."
    }
    
    enum Buttons: String {
        case Ok = "Ok"
        case Done = "Done"
        case Cancel = "Cancel"
        case Close = "Close"
        case Search = "Search"
    }
    
    enum Genders: String {
        case Male
        case Female
    }
}

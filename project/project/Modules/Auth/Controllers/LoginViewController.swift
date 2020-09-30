//
//  LoginViewController.swift
//  project
//
//  Created by Mohammad Bitar on 9/27/20.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: MasterViewController, GIDSignInDelegate {

    // MARK: - IBOUTLETS
    
    // MARK: - VARIABLES
    
    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
    }

    // MARK: - IBACTIONS
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        popViewController()
    }
    
    @IBAction func facebookButtonTapped(_ sender: UIButton) {
        authManager.facebookLogin(on: self) { [weak self] (success, user) in
            guard let strongSelf = self else { return }
            if success {
                UserDefaults.setValue(key: GlobalVariables.Parameters.IsLoggedIn.rawValue, value: "1")
                self?.goToHomePage()
            } else {
                Alert.showError(on: strongSelf, with: GlobalVariables.Messages.LoginFailed.rawValue)
                return
            }
        }
    }
    
    @IBAction func googleButtonTapped(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    // MARK: - FUNCTIONS
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if error != nil {
                return
            }
            
            self.observerSelector()
        }
    }
    
    func observerSelector() -> Void {
        if Reachability.isConnectedToNetwork() {
            showLoadingDialog()
            authManager.getGoogleUserDetails(completion: { [weak self] (success, user, id, error) in
                self?.dismissLoadingDialog()
                guard let strongSelf = self else { return }
                if error != nil {
                    Alert.showError(on: strongSelf, with: GlobalVariables.Messages.LoginFailed.rawValue)
                    return
                }
                
                if success {
                    UserDefaults.setValue(key: GlobalVariables.Parameters.IsLoggedIn.rawValue, value: "1")
                    self?.goToHomePage()
                } else {
                    Alert.showError(on: strongSelf, with: GlobalVariables.Messages.LoginFailed.rawValue)
                    return
                }
            })
        }
    }
}

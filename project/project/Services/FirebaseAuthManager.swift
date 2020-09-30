//
//  FirebaseAuthManager.swift
//  Kasban
//
//  Created by Mohammad Bitar on 10.02.2020.
//  Copyright © 2020 Mohammad Bitar. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import FacebookCore
import FacebookLogin
import FirebaseAuth

class FirebaseAuthManager {
    
    static let shared: FirebaseAuthManager = FirebaseAuthManager()
    private let readPermissions: [Permission] = [.publicProfile, .email]
    
    init() {}
    
    func  loginByPhoneNumber(phoneNumber: String, completion: @escaping (_ success: Bool, _ verificationId: String?, _ error: Error?) -> ()) {
        Auth.auth().settings?.isAppVerificationDisabledForTesting = false
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationId, error) in
            if error != nil {
                completion(false, nil, error)
            } else {
                UserDefaults.setValue(key: verificationId ?? "", value: GlobalVariables.Parameters.VerificationId.rawValue)
                completion(true, verificationId, nil)
            }
        }
    }
    
    func verifiyCode(verificationId: String, code: String, completion: @escaping (_ success: Bool, _ user: User?, _ error: Error?) -> ()) {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: code)
        Auth.auth().signIn(with: credential) { (authData, error) in
            if error != nil {
                completion(false, nil, error)
            } else {
                var token = ""
                authData?.user.getIDToken(completion: { (resultToken, error) in
                    if error == nil {
                        token = resultToken ?? ""
                    }
                })
                let user = User(userId: authData?.user.uid ?? "", email: authData?.user.email ?? "", name: authData?.user.displayName ?? "", token: token, image: "")
                completion(true, user, nil)
            }
        }
    }
}

// MARK: - Google
extension FirebaseAuthManager {
    
    func signOutFromGoogle() {
        GIDSignIn.sharedInstance()?.signOut()
    }
    
    func getGoogleUserDetails(completion: @escaping (_ success: Bool, _ user: User?, _ userId: String?, _ error: Error?) -> ()) {
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true, completion: { [weak self] (idToken, error) in
            if error != nil {
                self?.signOutFromGoogle()
                completion(false, nil, nil, error)
                return
            }
            let user = User(userId: currentUser?.uid ?? "", email: currentUser?.email ?? "", name: currentUser?.displayName ?? "", token: idToken ?? "", image: currentUser?.photoURL?.absoluteString ?? "")
            completion(true, user, idToken, nil)
        })
    }
}

// MARK: - Facebook
extension FirebaseAuthManager {
    
    func facebookLogin(on vc: UIViewController, completion: @escaping (_ success: Bool, _ user: User?) -> ()) {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: readPermissions, viewController: vc) { [weak self] (loginResult) in
            switch loginResult {
            case .success:
                self?.didLoginWithFacebook(completion: { (success, userResult, token, userId) in
                    if success {
                        guard let userInfo = userResult else { return }
                        let profileImage = "http://graph.facebook.com/\(userInfo["id"]!)/picture?type=large"
                        let user = User(userId: userId ?? "", email: userInfo["email"] as! String, name: userInfo["name"] as! String, token: token ?? "", image: profileImage)
                        completion(true, user)
                    } else {
                        completion(false, nil)
                    }
                })
            case .failed(_):
                completion(false, nil)
                break
            default:
                completion(false, nil)
                break
            }
        }
    }

    fileprivate func didLoginWithFacebook(completion: @escaping (_ success: Bool, _ result: [String: AnyObject]?, _ token: String?, _ userId: String?) -> Void) {
        // Successful log in with Facebook
        if let accessToken = AccessToken.current {
            // if firebase enabled, we login the user into firebase
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if error == nil {
                    GraphRequest(graphPath: "me", parameters: ["fields": "id, name, email"]).start { (connection, facebookResult, error) in
                        if let error = error {
                            print("the Error of Facebook \(error.localizedDescription)")
                            completion(false, nil, nil, nil)
                        } else {
                            guard let info = facebookResult as? [String: AnyObject] else { return }
                            completion(true, info, accessToken.tokenString, authResult?.user.uid)
                        }
                    }
                } else {
                    completion(false, nil, nil, nil)
                }
            }
        }
    }
    
}

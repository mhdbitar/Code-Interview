//
//  SplashViewController.swift
//  project
//
//  Created by Mohammad Bitar on 9/25/20.
//

import UIKit

class SplashViewController: MasterViewController {

    // MARK: - IBOUTLETS
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            if !UserDefaults.isUserLoggedIn() {
                self.goToSignupPage()
            } else {
                self.goToHomePage()
            }
        }
    }
    
    // MARK: - FUNCTIONS
    
    func goToSignupPage() {
        let sb = UIStoryboard(name: GlobalVariables.Storyboards.Auth.rawValue, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "FirstSignupViewController") as! FirstSignupViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

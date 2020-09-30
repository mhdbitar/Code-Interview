//
//  FirstSignupViewController.swift
//  project
//
//  Created by Mohammad Bitar on 9/25/20.
//

import UIKit

class FirstSignupViewController: MasterViewController {

    // MARK: - VARIABLES
    
    var viewModel: AuthViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = AuthViewModel(authManager: authManager)
    }
    
    // MARK: - IBACTIONS
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: GlobalVariables.Controllers.SecondSignupViewController.rawValue) as! SecondSignupViewController
        
        vc.viewModel = viewModel
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

//
//  MasterViewController.swift
//  project
//
//  Created by Mohammad Bitar on 9/25/20.
//

import UIKit

class MasterViewController: UIViewController {

    // MARK: - IBOUTLETS
    
    @IBOutlet weak var backButtonView: BackButton! {
        didSet {
            backButtonView.backButton.addTarget(self, action: #selector(popViewController), for: .touchUpInside)
        }
    }
    
    // MARK: - VARIABLES
    
    lazy var slideInTransitionDelegate = SlideInPresentationManager()
    var authManager: FirebaseAuthManager = FirebaseAuthManager.shared
    var progress: ProgressDialog! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progress = ProgressDialog(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - FUNCTIONS

    @objc func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    func goToHomePage() {
        let sb = UIStoryboard(name: GlobalVariables.Storyboards.Main.rawValue, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: GlobalVariables.Controllers.HomeViewController.rawValue) as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Loader
    func showLoadingDialog() {
        if !(self.progress.isShow) {
            self.progress.Show(animate: true, mesaj: "")
        }
    }
    func dismissLoadingDialog() {
        self.progress.Close()
    }
    
}

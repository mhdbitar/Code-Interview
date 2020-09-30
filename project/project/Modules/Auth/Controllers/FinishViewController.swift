//
//  FinishViewController.swift
//  project
//
//  Created by Mohammad Bitar on 9/30/20.
//

import UIKit

class FinishViewController: MasterViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - IBACTIONS
    
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        goToHomePage()
    }
    
}

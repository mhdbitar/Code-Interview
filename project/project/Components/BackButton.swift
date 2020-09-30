//
//  BackButton.swift
//  project
//
//  Created by Mohammad Bitar on 9/30/20.
//

import UIKit

class BackButton: UIView {
    
    // MARK: - IBOUTLETS
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var backContainer: CustomView! {
        didSet {
            backContainer.addBorder(width: 1.0, corner: backContainer.frame.size.width / 2, color: UIColor.clear.cgColor)
        }
    }
    
    // MARK:- Variables
    
    let nib = "BackButton"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit () {
        Bundle.main.loadNibNamed(nib, owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
}

//
//  HomeViewController.swift
//  project
//
//  Created by Mohammad Bitar on 9/29/20.
//

import UIKit

class HomeViewController: MasterViewController {

    // MARK: - IBOUTLETS
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.isHidden = true
            tableView.addBorder(width: 1, corner: 10, color: UIColor.clear.cgColor)
        }
    }
    
    // MARK: - CONSTANTS
    
    let baseWords: [String] = ["Cronyism", "Hundreds", "Belgium", "standard", "shotgun", "birds", "seven", "anointed", "doors", "mike", "Man", "Woman", "Men"]
    let comparable: Int = 50
    
    // MARK: - VARIABLES
    
    var resultWords: [String] = []
    var cashedWords: [String: [String]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: - FUNCTIONSs

    func setup() {
        searchTextField.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: GlobalVariables.ViewCells.WordTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: GlobalVariables.ViewCells.WordTableViewCell.rawValue)
    }
    
    func validate(keyword: String) -> Bool {
        
        if keyword == "" {
            return false
        }
        
        return true
    }
    
    func getKeys() -> [String] {
        return cashedWords.keys.map({ String($0) })
    }
    
    func shouldReadCash(keyword: String) -> Bool {
        if cashedWords.count > 0 {
            let keys = getKeys()
            if keys.contains(keyword) {
                return true
            }
        }
        
        return false
    }
    
    func readCash(keyword: String) {
        resultWords = cashedWords[keyword]!
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    func doTheSearch(keyword: String) {
        for i in 0..<baseWords.count {
            let distance = keyword.levenshteinDistance(bString: baseWords[i])
            if distance > comparable {
                resultWords.append(baseWords[i])
            }
        }
        if resultWords.count > 0 {
            cashedWords[keyword] = resultWords
            tableView.isHidden = false
            tableView.reloadData()
        } else {
            tableView.isHidden = true
            Alert.showWarning(on: self, with: GlobalVariables.Messages.NoData.rawValue)
        }
    }
        
    @objc func processTheValue() {
        showLoadingDialog()
        resultWords = []
        hideKeyboard()
        guard let keyword = searchTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            Alert.showError(on: self, with: GlobalVariables.Messages.FieldReuiqred.rawValue)
            return
        }
        searchTextField.text = ""
        if validate(keyword: keyword) {
            if shouldReadCash(keyword: keyword) {
                readCash(keyword: keyword)
            } else {
                doTheSearch(keyword: keyword)
            }
            dismissLoadingDialog()
        } else {
            dismissLoadingDialog()
            Alert.showError(on: self, with: GlobalVariables.Messages.FieldReuiqred.rawValue)
        }
    }
    
    // MARK: - IBACTIONS
    
    @IBAction func signoutButtonTapped(_ sender: UIButton) {
        UserDefaults.logout()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}

// MARK: - TABLEVIEW
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GlobalVariables.ViewCells.WordTableViewCell.rawValue, for: indexPath) as! WordTableViewCell
        cell.word = resultWords[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Did you mean:"
    }
    
}

// MARK: - TEXTFIELD
extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        processTheValue()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let bar = UIToolbar()
        let close = UIBarButtonItem(title: GlobalVariables.Buttons.Close.rawValue, style: .plain, target: self, action: #selector(hideKeyboard))
        let submit = UIBarButtonItem(title: GlobalVariables.Buttons.Search.rawValue, style: .done, target: self, action: #selector(processTheValue))
        
        close.tintColor = .red
        bar.items = [close, submit]
        bar.sizeToFit()
        textField.inputAccessoryView = bar
        return true
    }
}

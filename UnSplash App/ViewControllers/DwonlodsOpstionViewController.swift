//
//  DwonlodsOpstionViewController.swift
//  UnSplash App
//
//  Created by Girish Parate on 10/10/21.
//

import UIKit

class DwonlodsOpstionViewController: UITableViewController {

    let op :[String] = ["12","23","45","45"];
    
    let titleForPage = "Hello Work"
    
    var isCompleted :((_ selectedOption: String) -> ())? = nil
    func didSometingWithCode(completed: @escaping(_
        selectedOption: String) -> ()){
        self.isCompleted = completed
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return op.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = op[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let complted = isCompleted{
            complted(op[indexPath.row])
        }
    }
}

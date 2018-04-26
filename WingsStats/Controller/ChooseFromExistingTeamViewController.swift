//
//  ChooseFromExistingTeamViewController.swift
//  WingsStats
//
//  Created by Victor Fundberg on 2018-04-16.
//  Copyright © 2018 Victor Fundberg. All rights reserved.
//

import UIKit
import Firebase

class ChooseFromExistingTeamViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var teamPicker: UIPickerView!
    @IBOutlet weak var chooseTeamButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    let teams = ["A-laget","B-laget","Juniorlaget"]
    var dataBase : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamPicker.delegate = self
        teamPicker.dataSource = self
        dataBase = Database.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // Delegates and DataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return teams.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return teams[row]
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
